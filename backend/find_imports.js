const fs = require('fs');
const path = require('path');
function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(file => {
    file = path.join(dir, file);
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) { 
      results = results.concat(walk(file));
    } else { 
      if (file.endsWith('.ts') || file.endsWith('.js')) results.push(file);
    }
  });
  return results;
}
const files = walk('./src');
const packages = new Set();
files.forEach(f => {
  const content = fs.readFileSync(f, 'utf8');
  const regex = /(?:import.*?from\s+['"]([^'"]+)['"])|(?:require\(['"]([^'"]+)['"]\))/g;
  let match;
  while ((match = regex.exec(content)) !== null) {
    let pkg = match[1] || match[2];
    if (!pkg.startsWith('.')) {
      if (pkg.startsWith('@')) {
        packages.add(pkg.split('/').slice(0,2).join('/'));
      } else {
        packages.add(pkg.split('/')[0]);
      }
    }
  }
});
console.log(Array.from(packages).join('\n'));
