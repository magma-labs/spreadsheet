import resolve from '@rollup/plugin-node-resolve';
import babel from 'rollup-plugin-babel';
import {terser} from 'rollup-plugin-terser';
import css from 'rollup-plugin-css-only';
import scss from 'rollup-plugin-scss';
import commonjs from '@rollup/plugin-commonjs';

export default {
  input: 'app/javascript/spreadsheet/index.js',
  output: {
    file: 'dist/spreadsheet.js',
    format: 'es'
  },
  context: 'window',
  plugins: [
    resolve(),
    babel({
      exclude: 'node_modules/**'
    }),
    terser(),
		css(),
		scss(),
		commonjs({
			exclude: ['node_modules/marked/**']
		})
  ]  
}
