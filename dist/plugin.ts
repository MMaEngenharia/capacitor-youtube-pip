import { registerPlugin } from '@capacitor/core';

export interface YouTubePiPPlugin {
  open(options: { videoId: string }): Promise<void>;
}

const YouTubePiP = registerPlugin<YouTubePiPPlugin>('YouTubePiP');

export * from './definitions';
export { YouTubePiP };