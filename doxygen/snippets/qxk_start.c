int main() {
    . . .
    /* stack for the QXK's idle thread */
    static uint64_t idleStackSto[32];

    Test_ctor();  /* instantiate the Test "naked" thread */

    QF_init();    /* initialize the framework */
    BSP_init();   /* initialize the Board Support Package */

    /* initialize QXK... */
    QXK_init(idleStackSto, sizeof(idleStackSto));

    /* initialize publish-subscribe... */
    QF_psInit(subscrSto, Q_DIM(subscrSto));

    /* initialize event pools... */
    QF_poolInit(smlPoolSto, sizeof(smlPoolSto), sizeof(smlPoolSto[0]));

    /* start the active objects... */
    QACTIVE_START(AO_Table,                  /* AO to start */
                  (uint_fast8_t)(N_PHILO + 2), /* QP priority of the AO */
                  tableQueueSto,             /* event queue storage */
                  Q_DIM(tableQueueSto),      /* queue length [events] */
                  tableStackSto,             /* stack storage */
                  sizeof(tableStackSto),     /* stack size [bytes] */
                  (QEvt *)0);                /* initialization event */
    . . .

    /* start the "naked" thread */
    QXTHREAD_START(&XT_Test->super,          /* Thread to start */
                  (uint_fast8_t)10U,         /* QP priority of the thread */
                  testQueueSto,              /* message queue storage */
                  Q_DIM(testQueueSto),       /* message length [events] */
                  testStackSto,              /* stack storage */
                  sizeof(testStackSto),      /* stack size [bytes] */
                  (QEvt *)0);                /* initialization event */

    return QF_run(); /* run the QF application */
}
