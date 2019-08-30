import React from 'react'
import { View } from 'react-native'

import ZingMp3PlayerView from './ZingMp3.PlayerView'

const ZingMp3View: React.FC = (props) => {
    return (
        <View style={{ flex: 1 }}>
            <ZingMp3PlayerView />

        </View>
    )
}

export default ZingMp3View