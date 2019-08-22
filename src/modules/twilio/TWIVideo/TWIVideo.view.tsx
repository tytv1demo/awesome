import React from 'react'
import { AppState, View, Platform, AppStateStatus } from 'react-native'

import { TwiRoomView, TwiPreview, TwiRemoteView, RemoteParticipant } from 'react-native-twilio-video'

import { TWIVideoViewStyles } from './styles';
import { ControlButton } from './TWIVideo.ControllButton';

interface TWIVideoViewState {
    isConnected: boolean,
    participants: Array<RemoteParticipant>,
    shareVideo: boolean,
    shareAudio: boolean
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
            shareAudio: true
        }
       
    }

    componentDidMount(){
        AppState.addEventListener("change", this.onAppSateChange)
    }

    componentWillUnmount() {
        AppState.removeEventListener("change", this.onAppSateChange)
    }
    //MARK: EVENT

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

    //
    connect = () => {
        const token = Platform.select({
            ios: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzViYmM1MTk5OTEzMDk5MjNiODQxZGIyZWFkNDU4NzdhLTE1NjY0NTgyMjYiLCJpc3MiOiJTSzViYmM1MTk5OTEzMDk5MjNiODQxZGIyZWFkNDU4NzdhIiwic3ViIjoiQUM4MmM0MjNkY2Y5MzE1NDZmYmM3YjViMTRjMWJmMWQ5OCIsImV4cCI6MTU2NjQ2MTgyNiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiaW9zIiwidmlkZW8iOnt9fX0.PuosuRTARb8Eq6mBQx7G-VAE6Qh1MaGNcGkVBcaQ04I",
            android: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzViYmM1MTk5OTEzMDk5MjNiODQxZGIyZWFkNDU4NzdhLTE1NjY0NTgyNDAiLCJpc3MiOiJTSzViYmM1MTk5OTEzMDk5MjNiODQxZGIyZWFkNDU4NzdhIiwic3ViIjoiQUM4MmM0MjNkY2Y5MzE1NDZmYmM3YjViMTRjMWJmMWQ5OCIsImV4cCI6MTU2NjQ2MTg0MCwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiYW5kcm9pZCIsInZpZGVvIjp7fX19.sJU-cmKFDVtPXuNdEzTtlgvHcVS60ErH-99WD_JazmM"
        })
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

    //
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
        const { isConnected, shareAudio, shareVideo } = this.state
        return (
            <View style={TWIVideoViewStyles.controls}>
                <ControlButton
                    size={50}
                    onPress={this.toggleShareAudio}
                    color="orange"
                    iconStyle={{ width: 30, height: 30 }}
                    icon={shareAudio ? "https://image.flaticon.com/icons/png/512/41/41758.png" : "https://icon-library.net/images/white-microphone-icon/white-microphone-icon-6.jpg"}
                />
                <ControlButton
                    size={50}
                    color={isConnected ? "red" : "green"}
                    onPress={isConnected ? this.disConnect : this.connect}
                    iconStyle={{ width: 30, height: 30 }}
                    icon="https://iconsplace.com/wp-content/uploads/_icons/ffffff/256/png/phone-icon-18-256.png"
                />
                <ControlButton
                    size={50}
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
                        style={{
                            position: "absolute",
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            zIndex: 1
                        }}
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
