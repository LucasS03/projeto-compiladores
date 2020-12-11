# sena-- 

Esta linguagem está sendo desenvolvida na disciplina de compiladores. A linguagem ainda não está completa, aceita tipo inteiro, real e texto.

#### Marcadores de início e fim do programa
```
inicio
    @@ código 
    @@ ...
fim
```

#### Comentários
```
@@ para comentar uma linha, adicione dois arrobas na frente da linha
```

#### Tipos
- real: aceita um número inteiro `a << 10` (que vai ser convertido em real) ou real `a << 10.0`
- inteiro: aceita um número inteiro `a << 10` (um número real atribuído, será convertido `a << 10.5`, logo, `a` é igual a `10`)
- texto: aceita uma palavra `nome << "Lucas"`

#### Declaração de variáveis
```
real x
real y
real area
inteiro idade
texto nome
```

#### Atribuição de valores
```
inteiro a << 5
inteiro b
inteiro soma

b << 10
soma << a * b
```

#### Operação de escrita
```
@@ para textos
escrevat("Hello Word!")
escrevat(variavel)

@@ para inteiro
escrevai(variavel)
escrevai(5)

@@ para real
escreva(variavel)
escrevar(5.5 * 14.3)
```

#### Operação de leitura
```
real idade
escrevat("Digite sua idade: ")
leiar(idade)

@@ para real
leiar(variavel)

@@ para inteiro
leiai(variavel)

@@ para texto
leiat(variavel)
```

#### Operações matemáticas
```
escrevat("Soma: ")
escrevar(5.0 + 10)

escrevat("Subtração: ")
escrevar(5.0 - 10)

escrevat("Multiplicação: ")
escrevar(5.0 * 10)

escrevat("Divisão: ")
escrevar(5.0 / 10)

escrevat("Exponenciação: ")
escrevar(5.0 ^ 10)
```

#### Expressões matemáticas

```
escrevar(((a / b) + (a * b) - 1))
```

#### Exemplo 
```
inicio

  real b
  real h
  real area

  escrevat("Cálculo da área do retângulo")
  escrevat("") @@ pular linha

  escrevat("Digite a base: ")
  leiar(b)

  escrevat("Digite a altura: ")
  leiar(h)

  escrevat("")
  escrevat("A área do retângulo é: ")
  area << h * b
  escrevar(area)

fim
```
