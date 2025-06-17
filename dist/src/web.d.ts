import { WebPlugin } from '@capacitor/core';
import type { YouTubePiPPlugin } from '../plugin';
export declare class YouTubePiPWeb extends WebPlugin implements YouTubePiPPlugin {
    play(options: {
        videoId: string;
    }): Promise<void>;
    close(): Promise<void>;
}
