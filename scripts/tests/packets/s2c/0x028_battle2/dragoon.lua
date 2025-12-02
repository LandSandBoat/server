local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets   =
{
    ['Healing Breath sequence'] =
    {
        test     = function(player, mob)
            player:changeJob(xi.job.DRG)
            player:setLevel(99)
            player.actions:useAbility(player, xi.jobAbility.CALL_WYVERN)
            xi.test.world:tickEntity(player)
            player.actions:useAbility(player, xi.jobAbility.RESTORING_BREATH)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(5)
            player:despawnPet()
            xi.test.world:tickEntity(player)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.JOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.RESTORING_BREATH,
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
                                sub_kind  = 94,
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
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
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
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.HEALING_BREATH_IV,
                                message   = xi.msg.basic.READIES_SKILL_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_INTERRUPT,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 0,
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
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.PET_MOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.HEALING_BREATH_IV,
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
                                sub_kind  = 156,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = xi.msg.basic.JA_RECOVERS_HP_2,
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
    ['Smiting Breath out of range sequence'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DRG)
            player:setLevel(99)

            player.actions:useAbility(player, xi.jobAbility.CALL_WYVERN)
            xi.test.world:tickEntity(player)

            local wyvern = player:getPet()
            assert(wyvern)

            player.actions:useAbility(mob, xi.jobAbility.SMITING_BREATH)
            xi.test.world:tickEntity(player)
            xi.test.world:tickEntity(wyvern)
            mob:setPos(100, 100, 100)

            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.JOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.SMITING_BREATH,
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
                                sub_kind  = 94,
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
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
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
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.FROST_BREATH,
                                message   = xi.msg.basic.READIES_SKILL_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_INTERRUPT,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 0,
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
            {
                m_uID   = ph.IGNORE,
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
                                miss      = 1,
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.FROST_BREATH,
                                message   = xi.msg.basic.TOO_FAR_AWAY_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_INTERRUPT,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
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
    ['Frost Breath'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DRG)
            player:setLevel(99)

            mob:setPos(player:getXPos() + 2, player:getYPos(), player:getZPos())

            player.actions:useAbility(player, xi.jobAbility.CALL_WYVERN)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(1)

            local wyvern = player:getPet()
            assert(wyvern)

            player.actions:useAbility(mob, xi.jobAbility.SMITING_BREATH)
            xi.test.world:tickEntity(player)
            xi.test.world:tickEntity(wyvern)
            xi.test.world:tickEntity(mob) -- Tick mob to process incoming action
            xi.test.world:skipTime(1)

            -- Tick again to process the breath attack
            xi.test.world:tickEntity(player)
            xi.test.world:tickEntity(wyvern)
            xi.test.world:tickEntity(mob)

            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)
        end,

        expected =
        {
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
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
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.FROST_BREATH,
                                message   = xi.msg.basic.READIES_SKILL_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.PET_MOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.FROST_BREATH,
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
                                sub_kind  = 135,
                                info      = 0,
                                scale     = 0,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.USES_JA_TAKE_DAMAGE,
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
