import { WebPlugin } from '@capacitor/core';
import type { YouTubePiPPlugin } from '../plugin';

export class YouTubePiPWeb extends WebPlugin implements YouTubePiPPlugin {
  async play(options: { videoId: string }): Promise<void> {
    window.open(`https://www.youtube.com/embed/${options.videoId}?playsinline=1&autoplay=1`, '_blank');
  }
  async close(): Promise<void> {}
}
