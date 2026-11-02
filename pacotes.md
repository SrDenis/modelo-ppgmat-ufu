# Por que você está usando alguns pacotes não usuais?

Tenho vários motivos para isso, que variam para cada pacote. Vou explicar nesse documento o motivo de cada mudança:

- `zref-clever` ao invés de `cleveref`: o pacote `cleveref` [não é atualizado desde 2018](https://tex.stackexchange.com/questions/711418/the-current-status-of-cleveref) e o pacote `zref-clever` é uma alternativa.
- `zref` ao invés de `hyperref`: como escolhemos o `zref-clever` para substituir o `cleveref`, precisamos utilizar o `zref`.
- `keytheorems` ao invés de `thmtools`: o `keytheorems` suporta todas as funções do `thmtools` e tem algumas adições, como a possibilidade de repetir os teoremas e de manipular mais atributos dele. De qualquer maneira ele tem compatibilidade com o `thmtools`, então caso não queira você ainda pode utilizar ele.