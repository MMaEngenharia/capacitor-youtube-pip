import { registerPlugin } from '@capacitor/core';
export const YouTubePiP = registerPlugin('YouTubePiP', {
    web: () => import('./src/web').then(m => new m.YouTubePiPWeb())
});
