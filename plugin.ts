import { registerPlugin } from '@capacitor/core';

export interface YouTubePiPPlugin {
  play(options: { videoId: string }): Promise<void>;
  close(): Promise<void>;
}

export const YouTubePiP = registerPlugin<YouTubePiPPlugin>('YouTubePiP', {
  web: () => import('./src/web').then(m => new m.YouTubePiPWeb())
});