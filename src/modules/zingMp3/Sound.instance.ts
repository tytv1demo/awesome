import Sound from 'react-native-sound'
import { EventEmitter } from 'events'

class SoundManager extends EventEmitter {
    static instance: SoundManager

    static default() {
        if (!SoundManager.instance) {
            SoundManager.instance = new SoundManager()
        }
        return SoundManager.instance
    }
    constructor() {
        super()
    }
    currentPlayer?: Sound

    playNewSound = (): Promise<Sound> => {
        Sound.setCategory("Playback")
        return new Promise<Sound>((res, rej) => {
            const didConstructNewSound = (error: any) => {
                if (error) rej(error)
                res(this.currentPlayer)
                this.currentPlayer!.play()
            }
            this.currentPlayer = new Sound(
                "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                undefined,
                didConstructNewSound
            )
        })

    }


}


export default SoundManager