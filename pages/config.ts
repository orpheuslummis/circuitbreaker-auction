import { http, createConfig } from 'wagmi'

import { injected } from 'wagmi/connectors'
import { scrollSepolia } from 'viem/chains'

export const config = createConfig({
  chains: [scrollSepolia],
  connectors: [injected()],
  transports: {
    [scrollSepolia.id]: http('https://api-sepolia.scroll.network'),
  }
})

declare module 'wagmi' {
  interface Register {
    config: typeof config
  }
}
