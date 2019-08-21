import { StyleSheet } from 'react-native'

export const YTVideoListViewStyles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: 100
    },
    list: {
        flex: 1
    }
})

export const YTVideoItemStyles = StyleSheet.create({
    wrapper: {
        flex: 1,
        paddingHorizontal: 8
    },
    container: {
        flex: 1,
        borderRadius: 8,
        backgroundColor: "white",
        shadowColor: "#AAAAAA",
        shadowOffset: { height: 2, width: 2 },
        shadowOpacity: 0.8,
        shadowRadius: 2,
        elevation: 1
    },
    image: {
        borderTopLeftRadius: 8,
        borderTopRightRadius: 8,
        height: 160,
        width: '100%'
    },
    infomation: {
        padding: 8
    },
    name: {
        fontWeight: "500",
        fontSize: 19
    },
    desciption: {
        // flexDirection: 
    },
    author: {
        fontWeight: "400",
        fontSize: 14,
        color: "gray"
    },
    date: {
        fontWeight: "400",
        fontSize: 14,
        color: "gray"
    }

})