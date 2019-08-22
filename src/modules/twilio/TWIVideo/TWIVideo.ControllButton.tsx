import React from 'react'
import { TouchableOpacity, Image, StyleProp, ImageStyle, ViewStyle } from 'react-native'

interface ControlButtonProps {
    containerStyle?: StyleProp<ViewStyle>,
    icon: Object | string
    iconStyle?: StyleProp<ImageStyle>
    color?: string,
    size?: number,
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
        iconStyle
    } = props

    let source: Object = icon;
    if (typeof icon === "string") {
        source = { uri: icon }
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
            <Image
                style={iconStyle}
                source={source}
            />
        </TouchableOpacity>
    )
}