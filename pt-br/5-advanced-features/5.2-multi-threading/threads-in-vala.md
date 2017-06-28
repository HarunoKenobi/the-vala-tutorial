# Threads em Vala

Um programa escrito em Vala talvez tenha mais de um segmento de execução, habilitando-o a fazer mais de uma coisa simultaneamente. Exatamente como isso é gerenciado está fora do âmbito de Vala - threads podem estar compartilhando um único núcleo do processador ou não, dependendo do ambiente.

Uma thread em Vala não é definido em tempo de compilação, em vez disso é simplesmente uma parte do código Vala que é solicitado em tempo de execução para ser executado como um novo segmento de execução. Isto é feito usando os métodos estáticos da classe *Thread* em GLib, como mostrado no seguinte (muito simplificado) exemplo:

```vala
void* thread_func() {
    stdout.printf("Thread running.\n");
    return null;
}

int main(string[] args) {
    if (!Thread.supported()) {
        stderr.printf("Cannot run without threads.\n");
        return 1;
    }

    try {
        Thread.create(thread_func, false);
    } catch (ThreadError e) {
        return 1;
    }

    return 0;
}
```

Este curto programa requisitará a criação de uma nova thread e a executará. O código a ser executado em *thread\_func*. Note também o teste na inicialização do método main - um programa Vala não será habilitado para usar threads a menos que seja apropriadamente compilado, então se você construir este exemplo de maneira usual, ele somente lhe mostrará um erro e interromperá a execução. Ser capaz de verificar o suporte a threads em tempo de execução permite que um programa seja contruído para executar com  ou sem threads, se desejado. A fim de contruir com suporte a thread, execute:

`$ valac --thread threading-sample.vala`

Isto incluirá ambas bibliotecas necessárias e certificará de que o sistema de threads seja inicializado sempre que possível.

O programa irá agora executar sem falha de segmentação, mas ainda assim não atuará conforme esperado. Sem qualquer tipo de loop de evento, um programa Vala irá terminar quando sua primeira thread (a única criada para executar "main") finalizar.

Em ordem para controlar este comportamento, você pode habilitar threads para cooperar. Isto pode ser feito poderosamente usando loops de eventos e filas assícronas, porém nesta introdução à threads nós iremos apenas mostrar as capacidades básicas de threads.

[ Terminar ]

