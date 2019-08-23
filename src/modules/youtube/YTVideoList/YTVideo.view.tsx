import React from 'react'
import {
    View,
    Text,
    GestureResponderEvent,
    Animated,
    TouchableWithoutFeedback
} from 'react-native'

import Image from 'react-native-fast-image'
//@ts-ignore
import Lightbox from "react-native-lightbox";

import YTVideoListBridge from './YTVideoList.bridge'
import { YTVideoItemStyles } from './styles';

const AnimValue = Animated.Value

const YTVideoItem: React.FC = (props) => {
    const anim = new AnimValue(1)
    const onLongPress = (evt: GestureResponderEvent) => {
        const { } = evt.nativeEvent
        Animated.spring(
            anim,
            {
                toValue: 2,
                useNativeDriver: true
            }
        ).start()
    }
    const onPressOut = (evt: GestureResponderEvent) => {
        const { } = evt.nativeEvent
        Animated.spring(
            anim,
            {
                toValue: 1,
                useNativeDriver: true
            }
        ).start()
    }
    
    const doPushToDetail = () => {
        YTVideoListBridge.pushToDetail()
    }

    // MARK: render

    const renderInfomation = () => {
        return (
            <View style={YTVideoItemStyles.infomation}>
                <Text style={YTVideoItemStyles.name}>Avenger - End Game</Text>
                <View style={YTVideoItemStyles.desciption}>
                    <Text style={YTVideoItemStyles.author}>Trần Tý</Text>
                    <Text style={YTVideoItemStyles.date}>Phát hành: 12 Jun 2019</Text>
                </View>

            </View>
        )
    }
    const renderContent = () => {
        return (
            <View
                style={[YTVideoItemStyles.container]}>
                <Lightbox>
                    <Image
                        source={{ uri: "https://cdn.mos.cms.futurecdn.net/PBpaPfht3TSS2rSg5ezHE.jpg" }}
                        style={YTVideoItemStyles.image}
                    />
                </Lightbox>

                {renderInfomation()}
            </View>
        )
    }
    return (
        <View style={YTVideoItemStyles.wrapper}>
            <TouchableWithoutFeedback
                onPress={doPushToDetail}
            >
                {renderContent()}
            </TouchableWithoutFeedback>

        </View>
    )
}

export default YTVideoItem
