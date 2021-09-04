#include "task.h"

int main(int argc, char** argv)
{
    // NOTE: Ne pas modifier ce fichier.
    //
    // La logique de RunCmd sera réutilisée dans la partie 2 et 3 du
    // laboratoire.  Il fait donc plus de sens de l'isoler dans sa propre
    // fonction.

    return run_cmd(argc - 1, argv + 1);
}
