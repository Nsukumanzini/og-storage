import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Vercel's Next build sees Cloudflare-only support files even though the
  // application does not import them. The Sites build type-checks its own path.
  typescript: {
    ignoreBuildErrors: process.env.VERCEL === "1",
  },
};

export default nextConfig;
