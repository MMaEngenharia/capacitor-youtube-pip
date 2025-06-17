import { WebPlugin } from '@capacitor/core';
export class YouTubePiPWeb extends WebPlugin {
    async play(options) {
        window.open(`https://www.youtube.com/embed/${options.videoId}?playsinline=1&autoplay=1`, '_blank');
    }
    async close() { }
}
