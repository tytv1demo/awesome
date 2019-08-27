import React from 'react'
import { TouchableOpacity, StyleProp, ImageStyle, ViewStyle, ActivityIndicator } from 'react-native'
import Image from 'react-native-fast-image'

interface ControlButtonProps {
    containerStyle?: StyleProp<ViewStyle>,
    icon: Object | string
    iconStyle?: StyleProp<ImageStyle>
    color?: string,
    size?: number,
    isLoading?: boolean
    onPress?: () => void
}

const DF_SIZE = 45
const DF_COLOR = "green"


export const ControlButton: React.FC<ControlButtonProps> = (props) => {

    const {
        containerStyle,
        size = DF_SIZE,
        color = DF_COLOR,
        icon,
        onPress,
        iconStyle,
        //
        isLoading
    } = props

    let source: Object = icon;
    if (typeof icon === "string") {
        source = { uri: icon }
    }

    const renderContent = () => {
        if (isLoading) {
            return <ActivityIndicator color="white" />
        }
        return (
            <Image
                style={iconStyle}
                source={source}
            />
        )
    }

    return (
        <TouchableOpacity
            onPress={onPress}
            style={[{
                width: size,
                height: size,
                borderRadius: size * 0.5,
                backgroundColor: color,
                justifyContent: "center",
                alignItems: "center",
            }, containerStyle]}
        >
            {renderContent()}
        </TouchableOpacity>
    )
}