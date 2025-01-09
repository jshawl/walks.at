import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";

export default defineConfig({
  build: { sourcemap: true },
  plugins: [RubyPlugin()],
});
