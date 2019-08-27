import React from 'react'
import { AppState, View, Platform, AppStateStatus } from 'react-native'

import { TwiRoomView, TwiPreview, TwiRemoteView, RemoteParticipant } from 'react-native-twilio-video'

import { TWIVideoViewStyles } from './styles';
import { ControlButton } from './TWIVideo.ControllButton';

interface TWIVideoViewState {
    isConnected: boolean,
    participants: Array<RemoteParticipant>,
    shareVideo: boolean,
    shareAudio: boolean,
    token: string,
    error: string,
    status: "INIT" | "LOADING" | "DONE"
}

class TWIVideoView extends React.PureComponent<any, TWIVideoViewState> {

    activeShareVideoState: boolean = true
    roomView!: TwiRoomView

    refRoomView = (r: TwiRoomView) => this.roomView = r

    constructor(props: any) {
        super(props);
        this.state = {
            isConnected: false,
            participants: [],
            shareVideo: true,
            shareAudio: true,
            token: "",
            error: "",
            status: "INIT"
        }

    }

    componentDidMount() {
        AppState.addEventListener("change", this.onAppSateChange)
        this.setState({ status: "LOADING" })
        fetch("https://api-dev.spltty.com/api/user/twilio_token", {
            method: "post",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            body: JSON.stringify({
                identity: ((Math.random() * 10000) + new Date().getTime()).toFixed(0) + Platform.OS,
                platform: Platform.OS
            })
        }).then(response => {
            return response.json();
        }).then(({ data }) => {
            const { token } = data
            this.setState({ token })
        }).catch((error) => {
            this.setState({ error })
        }).then(() => {
            this.setState({ status: "DONE" })
        })
    }

    componentWillUnmount() {
        AppState.removeEventListener("change", this.onAppSateChange)
    }

    // MARK: METHOD
    connect = () => {
        const { token } = this.state
        this.roomView.nativeConnectWithOptions(
            token,
            "test"
        )
    }

    disConnect = () => {
        this.roomView.nativeDisconnect()
    }

    toggleShareVideo = () => {
        this.setState({ shareVideo: !this.state.shareVideo })
    }

    toggleShareAudio = () => {
        const { shareAudio } = this.state
        this.setState({ shareAudio: !shareAudio })
    }

    toggleCamera = () => {
        this.roomView.nativeFlipCamera()
    }

    // MARK: Listen event
    onAppSateChange = (status: AppStateStatus) => {
        switch (status) {
            case "active":
                this.setState({ shareVideo: this.activeShareVideoState })
                break;
            case "background":
                this.activeShareVideoState = this.state.shareVideo
                this.toggleShareVideo()
        }
    }

    onDidConnect = (participants: Array<RemoteParticipant>) => {

        this.setState({ participants, isConnected: true })
    }

    onDisConnected = () => {
        this.setState({ isConnected: false, participants: [] })
    }

    onParticipantConnected = (participants: Array<RemoteParticipant>) => {
        this.setState({ participants })
    }
    onParticipantDisConnected = (participants: Array<RemoteParticipant>) => {
        this.setState({ participants })
    }

    // MARK: RENDER

    renderControls = () => {
        const { isConnected, shareAudio, shareVideo, status } = this.state
        const isLoading = status === "LOADING"

        return (
            <View style={TWIVideoViewStyles.controls}>
                <ControlButton
                    size={50}
                    isLoading={isLoading}
                    onPress={this.toggleShareAudio}
                    color="orange"
                    iconStyle={{ width: 30, height: 30 }}
                    icon={shareAudio ? "https://image.flaticon.com/icons/png/512/41/41758.png" : "https://icon-library.net/images/white-microphone-icon/white-microphone-icon-6.jpg"}
                />
                <ControlButton
                    size={50}
                    isLoading={isLoading}
                    color={isConnected ? "red" : "green"}
                    onPress={isConnected ? this.disConnect : this.connect}
                    iconStyle={{ width: 30, height: 30 }}
                    icon="https://iconsplace.com/wp-content/uploads/_icons/ffffff/256/png/phone-icon-18-256.png"
                />
                <ControlButton
                    size={50}
                    isLoading={isLoading}
                    onPress={this.toggleShareVideo}
                    color="green"
                    iconStyle={{ width: 30, height: 30 }}
                    icon={shareVideo ? "https://png.pngtree.com/svg/20150629/slash_1368083.png" : "https://www.nycc.edu/themes/nycc/images/icon-play-video-white.png"}
                />
            </View>
        )
    }

    render() {
        const { shareVideo, shareAudio, participants } = this.state
        return (
            <View style={TWIVideoViewStyles.container} >

                <TwiRoomView
                    ref={this.refRoomView}
                    style={TWIVideoViewStyles.room}
                    onDidConnect={this.onDidConnect}
                    onParticipantConnected={this.onParticipantConnected}
                    onParticipantDisConnected={this.onParticipantDisConnected}
                    shareVideo={shareVideo}
                    shareAudio={shareAudio}
                    onDisConnected={this.onDisConnected}
                >

                    {participants.map(par => <TwiRemoteView
                        key={par.identity}
                        participantIdentity={par.identity}
                        style={{ flex: 1 }}
                    />)}
                    <TwiPreview
                        style={TWIVideoViewStyles.preview}
                    />
                    <ControlButton
                        containerStyle={{ position: "absolute", top: 80, left: 20, zIndex: 2 }}
                        size={50}
                        onPress={this.toggleCamera}
                        color="#BBBBBB"
                        iconStyle={{ width: 30, height: 30 }}
                        icon="https://iconsplace.com/wp-content/uploads/_icons/ffffff/256/png/rotate-camera-icon-18-256.png"
                    />

                    {this.renderControls()}
                </TwiRoomView>

            </View>
        )
    }
}

export default TWIVideoView
