local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Ignis (RuneFencer)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RUN)
            player:setLevel(99)
            player.actions:useAbility(player, xi.jobAbility.IGNIS)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.JOBABILITY_FINISH,
            cmd_arg = xi.jobAbility.IGNIS,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 2,
                            sub_kind  = 291,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = xi.msg.basic.USES_JA,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Vallation (RuneFencer)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RUN)
            player:setLevel(99)
            player:addStatusEffect(xi.effect.IGNIS, 1, 0, 300)
            player.actions:useAbility(player, xi.jobAbility.VALLATION)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RUNEFENCER,
            cmd_arg = xi.jobAbility.VALLATION,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 3,
                            sub_kind  = 0,
                            info      = 1, -- Ignis
                            scale     = 0,
                            value     = xi.effect.VALLATION,
                            message   = xi.msg.basic.VALLATION_GAIN,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Liement (RuneFencer)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RUN)
            player:setLevel(99)
            player:addStatusEffect(xi.effect.IGNIS, 1, 0, 300)
            player.actions:useAbility(player, xi.jobAbility.LIEMENT)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RUNEFENCER,
            cmd_arg = xi.jobAbility.LIEMENT,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 3,
                            sub_kind  = 3,
                            info      = 1,
                            scale     = 0,
                            value     = xi.effect.LIEMENT,
                            message   = xi.msg.basic.LIEMENT_GAIN,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Swipe (Sulpor) (RuneFencer)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RUN)
            player:setLevel(99)
            player:addItem(xi.item.CHAOSBRINGER)
            player:equipItem(xi.item.CHAOSBRINGER)
            player.actions:engage(mob)
            player:addStatusEffect(xi.effect.SULPOR, 1, 0, 300)
            player.actions:useAbility(mob, xi.jobAbility.SWIPE)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RUNEFENCER,
            cmd_arg = xi.jobAbility.SWIPE,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 3,
                            sub_kind  = 10,
                            info      = 10,
                            scale     = 0,
                            value     = ph.IGNORE,
                            message   = xi.msg.basic.JA_DAMAGE,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Lunge (RuneFencer)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RUN)
            player:setLevel(99)
            player:addItem(xi.item.CHAOSBRINGER)
            player:equipItem(xi.item.CHAOSBRINGER)
            player.actions:engage(mob)
            player:addStatusEffect(xi.effect.SULPOR, 1, 0, 300)
            player.actions:useAbility(mob, xi.jobAbility.LUNGE)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RUNEFENCER,
            cmd_arg = xi.jobAbility.LUNGE,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 3,
                            sub_kind  = 10,
                            info      = 10,
                            scale     = 0,
                            value     = ph.IGNORE,
                            message   = xi.msg.basic.JA_DAMAGE,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Gambit (RuneFencer)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RUN)
            player:setLevel(99)
            player:addItem(xi.item.CHAOSBRINGER)
            player:equipItem(xi.item.CHAOSBRINGER)
            player.actions:engage(mob)
            player:addStatusEffect(xi.effect.SULPOR, 1, 0, 300)
            player.actions:useAbility(mob, xi.jobAbility.GAMBIT)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RUNEFENCER,
            cmd_arg = xi.jobAbility.GAMBIT,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 3,
                            sub_kind  = 20,
                            info      = 10,
                            scale     = 0,
                            value     = xi.effect.GAMBIT,
                            message   = xi.msg.basic.GAMBIT_GAIN,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
}

return packets
