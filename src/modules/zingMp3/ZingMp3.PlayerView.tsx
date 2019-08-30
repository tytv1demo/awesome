import React, { useEffect } from 'react'
import { View, Dimensions } from 'react-native'

import Sound from 'react-native-sound'
import Image from 'react-native-fast-image'
import { ZingMp3PlayerStyles } from './styles';
import SoundManager from './Sound.instance';


const { width: screenWidth, height: screenHeight } = Dimensions.get("window")

const ZingMp3PlayerView: React.FC = (props) => {
    const soundManager = SoundManager.default()
    let sound: Sound
    const mountingEffect =  () => {
        soundManager.playNewSound()
            .then(s => sound = s)
            .catch()
    }
    useEffect(mountingEffect, [])
    // sound.
    const renderCD = () => {
        const size = screenWidth * 0.75
        return (
            <View style={ZingMp3PlayerStyles.cdContainer}>
                <Image
                    style={{ width: size, height: size, borderRadius: size * 0.5 }}
                    source={{ uri: "https://static.qobuz.com/images/covers/jb/f1/c965x3w74f1jb_600.jpg" }}
                />
            </View>

        )
    }
    return (
        <View style={ZingMp3PlayerStyles.container}>
            {renderCD()}

        </View>
    )
}

export default ZingMp3PlayerView