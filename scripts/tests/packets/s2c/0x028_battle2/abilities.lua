local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Composure Self'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RDM)
            player:setLevel(99)
            player.actions:useAbility(player, xi.jobAbility.COMPOSURE)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.JOBABILITY_FINISH,
            cmd_arg = xi.jobAbility.COMPOSURE,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.HIT,
                            kind      = 2,
                            sub_kind  = 215,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.COMPOSURE,
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
    ['Provoke Mob'] =
    {
        test = function(player, mob)
            player.actions:useAbility(mob, xi.jobAbility.PROVOKE)
            xi.test.world:tickEntity(player)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.JOBABILITY_FINISH,
            cmd_arg = xi.jobAbility.PROVOKE,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.HIT,
                            kind      = 2,
                            sub_kind  = 3,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = 119,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Paralyzed'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DRG)
            player:setLevel(99)
            player:setMod(xi.mod.PARALYZE, 100)
            player.actions:useAbility(mob, xi.jobAbility.JUMP)
            xi.test.world:tickEntity(player)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_FINISH,
                cmd_arg = 0,
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
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = xi.msg.basic.IS_PARALYZED_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_FINISH,
                cmd_arg = 0,
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
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = xi.msg.basic.IS_PARALYZED_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },
    ['Mijin Gakure'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.NIN)
            player:setLevel(99)

            player.actions:useAbility(mob, xi.jobAbility.MIJIN_GAKURE)
            xi.test.world:skipTime(5)
            player:sendReraise(4)
            player.actions:acceptRaise()
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.JOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.MIJIN_GAKURE,
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
                                kind      = 2,
                                sub_kind  = 93,
                                info      = 0, -- TODO: Mijin supposed to set info
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
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = 4,
                cmd_arg = 0,
                info    = 0, -- TODO: Retail sends 100?
                target  =
                {
                    {
                        m_uID      = ph.TEST_CHAR,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 847,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = 0,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },
}

return packets
