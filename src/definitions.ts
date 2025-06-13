export interface YouTubePiPPlugin {
  open(options: { videoId: string }): Promise<void>;
}