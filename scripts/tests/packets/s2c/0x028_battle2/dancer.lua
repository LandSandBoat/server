local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Drain Samba'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:setTP(3000)
            player.actions:useAbility(player, xi.jobAbility.DRAIN_SAMBA)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.DANCER,
            cmd_arg = xi.jobAbility.DRAIN_SAMBA,
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
                            sub_kind  = 0,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.DRAIN_SAMBA,
                            message   = xi.msg.basic.SKILL_GAIN_EFFECT_2,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Curing Waltz'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:setTP(3000)
            player.actions:useAbility(player, xi.jobAbility.CURING_WALTZ)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.DANCER,
            cmd_arg = 190,
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
                            sub_kind  = 6,
                            info      = 0,
                            scale     = 0,
                            value     = ph.IGNORE, -- HP healed
                            message   = xi.msg.basic.JA_RECOVERS_HP,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Chocobo Jig'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:setTP(3000)
            player.actions:useAbility(player, xi.jobAbility.CHOCOBO_JIG)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.DANCER,
            cmd_arg = 197,
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
                            sub_kind  = 13,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.QUICKENING,
                            message   = xi.msg.basic.CHOCOBO_JIG,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Quick Step'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1.0)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addItem(xi.item.TERPSICHORE_99)
            player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
            player:setTP(3000)
            player.actions:engage(mob)
            player.actions:useAbility(mob, xi.jobAbility.QUICKSTEP)
            xi.test.world:skipTime(1)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.DANCER,
            cmd_arg = 201,
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
                            sub_kind  = 16,
                            info      = 5,
                            scale     = 0,
                            value     = 1,
                            message   = 519,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Animated Flourish'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addStatusEffectEx(xi.effect.FINISHING_MOVE_1, xi.effect.FINISHING_MOVE_6, 6, 0, 7200)
            player.actions:useAbility(mob, xi.jobAbility.ANIMATED_FLOURISH)
            xi.test.world:tickEntity(player)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.JOBABILITY_FINISH,
            cmd_arg = 204,
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
                            sub_kind  = 181,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = xi.msg.basic.USE_JA_ON,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Reverse Flourish'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addStatusEffectEx(xi.effect.FINISHING_MOVE_1, xi.effect.FINISHING_MOVE_6, 6, 0, 7200)
            player.actions:useAbility(player, xi.jobAbility.REVERSE_FLOURISH)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.JOBABILITY_FINISH,
            cmd_arg = xi.jobAbility.REVERSE_FLOURISH,
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
                            sub_kind  = 182,
                            info      = 0,
                            scale     = 0,
                            value     = 600, -- TP gained
                            message   = xi.msg.basic.WILD_FLOURISH_TP,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Divine Waltz'] =
    {
        test = function(player, mob)
            local p2 = xi.test.world:spawnPlayer({ zone = xi.zone.QUFIM_ISLAND })
            player.actions:inviteToParty(p2)
            p2.actions:acceptPartyInvite()
            player.actions:move(mob:getXPos(), mob:getYPos(), mob:getZPos())
            p2.actions:move(mob:getXPos(), mob:getYPos(), mob:getZPos())
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:setTP(3000)
            player.actions:useAbility(player, xi.jobAbility.DIVINE_WALTZ)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 2,
            res_sum = 0,
            cmd_no  = xi.action.category.DANCER,
            cmd_arg = xi.jobAbility.DIVINE_WALTZ,
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
                            sub_kind  = 11,
                            info      = 0,
                            scale     = 0,
                            value     = ph.IGNORE, -- HP healed
                            message   = xi.msg.basic.JA_RECOVERS_HP,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
                {
                    m_uID      = ph.IGNORE,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 2,
                            sub_kind  = 11,
                            info      = 0,
                            scale     = 0,
                            value     = ph.IGNORE, -- HP Healed
                            message   = xi.msg.basic.SELF_HEAL_SECONDARY,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Violent Flourish'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1.0)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addItem(xi.item.TERPSICHORE_99)
            player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
            player:addStatusEffectEx(xi.effect.FINISHING_MOVE_1, xi.effect.FINISHING_MOVE_6, 6, 0, 7200)
            player.actions:engage(mob)
            player.actions:useAbility(mob, xi.jobAbility.VIOLENT_FLOURISH)
            xi.test.world:skipTime(1)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.DANCER,
            cmd_arg = xi.jobAbility.VIOLENT_FLOURISH,
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
                            sub_kind  = 26,
                            info      = 7,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = xi.msg.basic.VIOLENT_FLOURISH_STUN,
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
