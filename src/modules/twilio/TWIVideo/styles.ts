import { StyleSheet } from 'react-native'

export const TWIVideoViewStyles = StyleSheet.create({
    container: {
        flex: 50,
        paddingTop: 20,
        justifyContent: "flex-end"
    },
    room: {
        flex: 1
    },
    preview: {
        position: "absolute",
        width: 100,
        height: 180,
        top: 20,
        right: 20,
        zIndex: 2
    },
    controls: {
        flexDirection: "row",
        justifyContent: "space-between",
        position: "absolute",
        bottom: 16,
        width: "70%",
        left: "15%",
        padding: 20,
        zIndex: 2
    }
})
