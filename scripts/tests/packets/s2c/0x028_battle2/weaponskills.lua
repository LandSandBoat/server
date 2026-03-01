local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Sequence'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addItem(xi.item.TERPSICHORE_99)
            player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
            player:setTP(3000)
            player.actions:engage(mob)
            player.actions:useWeaponskill(mob, xi.weaponskill.PYRRHIC_KLEOS)
            xi.test.world:skipTime(2)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
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
                                value     = xi.weaponskill.PYRRHIC_KLEOS,
                                message   = xi.msg.basic.READIES_WS,
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
                cmd_no  = xi.action.category.WEAPONSKILL_FINISH,
                cmd_arg = xi.weaponskill.PYRRHIC_KLEOS,
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
                                sub_kind  = 44,
                                info      = ph.IGNORE,
                                scale     = ph.IGNORE,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.DAMAGE,
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
    ['Out of range'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addItem(xi.item.TERPSICHORE_99)
            player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
            player:setTP(3000)
            player.actions:engage(mob)
            player.actions:move(mob:getXPos() - 15, mob:getYPos(), mob:getZPos())
            player.actions:useWeaponskill(mob, xi.weaponskill.PYRRHIC_KLEOS)
            xi.test.world:skipTime(2)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
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
                                value     = xi.weaponskill.PYRRHIC_KLEOS,
                                message   = xi.msg.basic.READIES_WS,
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
                                message   = xi.msg.basic.TOO_FAR_AWAY,
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
    ['Guarded WS'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            player:gotoZone(xi.zone.DYNAMIS_SAN_DORIA)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addItem(xi.item.TERPSICHORE_99)
            player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
            player:setTP(3000)
            local mnkMob = player.entities:moveTo('Vanguard_Grappler')
            stub('xi.combat.physical.isGuarded', true)
            mnkMob:setMod(xi.mod.ADDITIVE_GUARD, 100)

            player.actions:engage(mnkMob)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(1)
            player.actions:useWeaponskill(mnkMob, xi.weaponskill.PYRRHIC_KLEOS)
            xi.test.world:skipTime(3)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.WEAPONSKILL_FINISH,
            cmd_arg = xi.weaponskill.PYRRHIC_KLEOS,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.IGNORE,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.GUARD,
                            kind      = 3,
                            sub_kind  = 44,
                            info      = ph.IGNORE,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = xi.msg.basic.DAMAGE,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Skillchain'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            mob:setUnkillable(true)
            player:changeJob(xi.job.SAM)
            player:setLevel(99)
            player:addItem(xi.item.MASAMUNE_99)
            player:equipItem(xi.item.MASAMUNE_99, nil, xi.slot.MAIN)

            player.actions:skillchain(mob, xi.weaponskill.TACHI_FUDO, xi.weaponskill.TACHI_FUDO)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
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
                                value     = xi.weaponskill.TACHI_FUDO,
                                message   = xi.msg.basic.READIES_WS,
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
                cmd_no  = xi.action.category.WEAPONSKILL_FINISH,
                cmd_arg = xi.weaponskill.TACHI_FUDO,
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
                                sub_kind  = 178,
                                info      = ph.IGNORE,
                                scale     = ph.IGNORE,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.DAMAGE,
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
                                value     = xi.weaponskill.TACHI_FUDO,
                                message   = xi.msg.basic.READIES_WS,
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
                cmd_no  = xi.action.category.WEAPONSKILL_FINISH,
                cmd_arg = xi.weaponskill.TACHI_FUDO,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_MOB,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss         = 0,
                                kind         = 3,
                                sub_kind     = 178,
                                info         = ph.IGNORE,
                                scale        = ph.IGNORE,
                                value        = ph.IGNORE,
                                message      = xi.msg.basic.DAMAGE,
                                bit          = 0,
                                has_proc     = true,
                                proc_kind    = 1, -- Light
                                proc_info    = 0,
                                proc_value   = ph.IGNORE,
                                proc_message = 288,
                                has_react    = false,
                            },
                        },
                    },
                },
            },
        },
    },
    ['Guaranteed critical WS'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            -- True Strike is guaranteed to crit
            mob:setUnkillable(true)
            player:changeJob(xi.job.WHM)
            player:setLevel(99)
            player:setSkillLevel(xi.skill.CLUB, 1750)
            player:addItem(xi.item.ASH_CLUB)
            player:equipItem(xi.item.ASH_CLUB, nil, xi.slot.MAIN)
            player:setTP(3000)
            player.actions:engage(mob)
            player.actions:useWeaponskill(mob, xi.weaponskill.TRUE_STRIKE)
            xi.test.world:skipTime(1)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
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
                                value     = xi.weaponskill.TRUE_STRIKE,
                                message   = xi.msg.basic.READIES_WS,
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
                cmd_no  = xi.action.category.WEAPONSKILL_FINISH,
                cmd_arg = xi.weaponskill.TRUE_STRIKE,
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
                                sub_kind  = 82,
                                info      = 2,
                                scale     = ph.IGNORE,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.DAMAGE,
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
    ['Eventually critical WS'] =
    {
        test = function(player, mob)
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            mob:setUnkillable(true)
            player:changeJob(xi.job.MNK)
            player:setLevel(99)
            player:addItem(xi.item.VERETHRAGNA_99)
            player:equipItem(xi.item.VERETHRAGNA_99, nil, xi.slot.MAIN)
            player.actions:engage(mob)
            xi.test.world:skipTime(1)

            -- Surely we'll get at least 1 crit in 10 attempts...
            for i = 1, 10 do
                player:setTP(3000)
                player.actions:useWeaponskill(mob, xi.weaponskill.VICTORY_SMITE)
                xi.test.world:skipTime(1)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.WEAPONSKILL_FINISH,
            cmd_arg = xi.weaponskill.VICTORY_SMITE,
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
                            sub_kind  = 29,
                            info      = 2,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = xi.msg.basic.DAMAGE,
                            bit       = 0,
                            has_proc  = ph.IGNORE,
                            has_react = ph.IGNORE,
                        },
                    },
                },
            },
        },
    },
}

return packets
