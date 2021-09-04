#include <assert.h>
#include <stddef.h>

#include "task.h"

int run_cmd(int argc, char** argv)
{
    assert(argc >= 0);
    assert(argv != NULL);

    // TODO: Implémenter ici la logique de la partie 1 du laboratoire.
    //
    // Si `RunCmd` a été appelé avec `./RunCmd ls -la /usr/src`, le paramêtre
    // `argv` de cette fonction sera ["ls", "-la", "/usr/src"] et le paramêtre
    // `argc` de cette fonction sera 3.
    //
    // "./RunCmd" est exclu de `argv` et `argc` dût à la ligne 11 de *RunCmd.c*.

    return -1;
}
