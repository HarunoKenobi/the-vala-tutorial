# Controle de Recursos

Sempre que mais de um segmento de execução, ou seja threads, estão sendo executados simultaneamente, existe uma chance de os dados serem acessados simultaneamente. Isto pode conduzir a uma concorrência condicionada, onde o resultado depende de quando o sistema decide alternar entre os segmentos de execução.

Para controlar esta situação, você pode usar a palavra chave `lock` para garantir que certos blocos de códigos não irão ser interrompidos por outros segmentos de execução que necessita acessar os mesmos dados. O melhor maneira de mostrar esta probabilidade com um exemplo é:

```vala
public class Test : GLib.Object {

    private int a { get; set; }

    public void action_1() {
        lock (a) {
            int tmp = a;
            tmp++;
            a = tmp;
        }
    }

    public void action_2() {
        lock (a) {
            int tmp = a;
            tmp--;
            a = tmp;
        }
    }
}
```

Esta classe define dois métodos, onde ambos necessitam mudar o valor de "a". Se não houvesse declaração de bloqueio aqui, seria possível que as intruções nestes métodos fossem entrelaçadas, e a alteração resultante para "a" seria efetivamente aleatória. Como existem as intruções de bloqueio `lock` aqui, Vala irá garantir que se uma thread boqueou "a", outra thread que necessita do mesmo bloqueio irá ter que esperar sua vez.

Em vala somente é possível bloquear membros do objeto que está executando o código. Isso pode parecer uma grande restrição, mas na verdade o uso padrão para esta técnica deve envolver classes que são individualmente responsáveis pelo controle de um recurso, assim todos os bloqueios será realmente interno à classe. Da mesma forma, no exemplo acima, todos os acessos para "a" estão encapsulados nas classes.