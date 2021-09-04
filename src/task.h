#ifndef LOG710__TASK
#define LOG710__TASK

/**
 * Utilisez cette valeur comme retour de `run_cmd` pour indiquer que la fonction
 * exec a échouée.
 *
 * Il ne faut pas afficher de statistiques si exec échoue.
 */
#define RUN_CMD_EXE_NOT_FOUND 127

/**
 * @brief Exécute la commande dans @p argc et @p argv en faisant exactement se
 * qui est demandé dans l'exécutable @e RunCmd.
 *
 * @param argc Le nombre d'arguments
 * @param argv Le tableau d'arguments
 * @return int Négatif pour une erreur, succès autrement
 */
int run_cmd(int argc, char** argv);

// TODO: Implémenter une abstraction pour les tâches.
//
// NOTE: Quelques questions pour vous guider et vous causer réflexion:
//   - Qu'est-ce une tâche?
//   - Quelles sont les différences entres les tâches en avant et arrière-plan?
//   - Quelle est l'information nécessaire à sauvegarder pour gérer des tâches?
//
// Vous pouvez toujours venir me voir si vous avez besoin d'aide.

#endif
