# Coleções

[Gee](/Projects/Libgee) é uma biblioteca de classes de coleções, escrita em Vala. As classes devem ser todas familiarizadas para usuários de bibliotecas tais como a JFC do Java. Gee consiste de um conjunto de interfaces e vários tipos que implementam estas em diferentes maneiras.

Se vocẽ quer usar Gee na sua aplicação, instale a biblioteca separadamente no seu sistema. Gee pode ser obtido [por esse link](http://live.gnome.org/Projects/Libgee). Para usar a biblioteca você precisa compilar seus programas com `--pkg gee-0.8`.

Os tipos fundamentais da coleção são:

-   Listas: Coleção de itens ordenados, acessível por índice numérico.

-   Conjuntos: Unordered collections of distinct.[Review]

-   Mapas: Coleção de itens não ordenados, acessível por índice de tipo arbitrário

Todas as listas e conjuntos na biblioteca implementam a interface *Collection*, e todos os mapas implementam a interface *Map*. Listas também implementam a interface *List* e conjuntos implementam a interface *Set*. Essas interfaces comuns não significa somente que todas coleções de um tipo similar podem ser usado indistintamente, mas também que novas coleções podem ser escritas usando as mesmas interfaces, e  por isso usado com código existente.

Também comum para todos os tipos *Collection* é a interface *Iterable*. Isto significa que qualquer objeto dentro desta categoria pode ser iterado completamente usando um padrão de conjunto de métodos, ou diretamente em Vala usando a sintaxe `foreach`.

Todas as classes e interfaces usam o sistema de genéricos. Isso significa que eles precisam ser instanciados com um tipo particular ou conjunto de tipos que eles irão conter. O sistema irá garantir que somente tipos desejados possam ser colocados nas coleções, e que quando objetos são recuperados eles são retornados com o tipo correto.

[Documentação completa do Gee](http://valadoc.org/gee-0.8/index.htm) e [Exemplos com Gee](/Projects/Vala/GeeSamples).

Algumas classes importantes do Gee são:

### ArrayList


Implementa: Iterable<G>, Collection<G>, List<G>

Uma lista ordenada de itens do tipo `G` suportado por uma matriz de redimensionamento dinâmico. Este tipo é muito rápido para acessar dados, mas potencialmente lento na inserão de itens em qualquer lugar que não seja no final, ou na inserção de itens quando a matriz interna está cheia.

### HashMap

Implementa: Iterable<Entry<K,V>>, Map<K,V>

Um mapa 1:1 dos elementos do tipo `K` para elementos do tipo `V`. O mapeamento é feito calculando um valor hash para cada chave - este pode ser customizado fornecendo ponteiros para funções para hash e testando igualdade de chaves de maneiras específicas.

Você pode opcionalmente passar hash customizado e funções 'equal' para o construtor, por exemplo:

```vala
var map = new Gee.HashMap<Foo, Object>(foo_hash, foo_equal);
```

Para strings e inteiros o hash e funções 'equal' são detectados automaticamente, e os objetos são distinguidos pelas suas referências por padrão. Você tem que prover hash customizado e funções 'equal' somente se você quiser sobreescrever o comportamento padrão.

### HashSet

Implementa: Iterable<G>, Collection<G>, Set<G>

Um conjunto de elementaros do tipo `G`. Duplicados são detectados calculando um valor hash para cada chave - este pode ser customizado provendo ponteiros para funções para hash e testando a igualdade das chaves de maneiras específicas.

### Read-Only Views

Você pode pegar uma read-only view de uma coleção através da propriedade *read_only_view*, e.g. `meu_mapa.read_only_view`. Isto retornará um wrapper[Review] que tem a mesma interface que sua coleção contida, mas não habilitará qualquer forma de modificação, ou qualquer acesso à colleção contida.