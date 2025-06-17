export interface YouTubePiPPlugin {
    play(options: {
        videoId: string;
    }): Promise<void>;
    close(): Promise<void>;
}
export declare const YouTubePiP: YouTubePiPPlugin;
