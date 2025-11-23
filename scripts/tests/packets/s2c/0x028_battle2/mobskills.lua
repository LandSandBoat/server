local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Bats Sonic Boom (Skill Prepare)'] =
    {
        test = function(player, mob)
            player:gotoZone(xi.zone.UPPER_DELKFUTTS_TOWER)
            local bats = player.entities:moveTo('Incubus_Bats')
            bats:addTP(3000)
            bats:useMobAbility(xi.mobSkill.SONIC_BOOM_1, player)
            xi.test.world:tickEntity(bats) -- Tick the AI so the skill gets readied
        end,

        expected =
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
                            value     = xi.mobSkill.SONIC_BOOM_1,
                            message   = xi.msg.basic.READIES_SKILL,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Bats Sonic Boom Miss (Skill Finish)'] =
    {
        test = function(player, mob)
            -- Force the skill to miss
            stub('xi.mobskills.mobStatusEffectMove', xi.msg.basic.SKILL_MISS)
            player:gotoZone(xi.zone.UPPER_DELKFUTTS_TOWER)
            local bats = player.entities:moveTo('Incubus_Bats') -- Incubus Bats
            bats:addTP(3000)
            bats:useMobAbility(xi.mobSkill.SONIC_BOOM_1, player, 0)
            xi.test.world:tickEntity(bats) -- Tick the AI so the skill gets readied
        end,

        expected =
        {
            m_uID   = ph.IGNORE,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MOBABILITY_FINISH,
            cmd_arg = xi.mobSkill.SONIC_BOOM_1,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = 1,
                            kind      = 3,
                            sub_kind  = 137,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = xi.msg.basic.SKILL_MISS,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Perfect Dodge (MobSkillFinish)'] =
    {
        test = function(player, mob)
            player:gotoZone(xi.zone.DYNAMIS_SAN_DORIA)
            local thfMob = player.entities:moveTo('Vanguard_Pillager')
            thfMob:useMobAbility(xi.jsa.PERFECT_DODGE)
            xi.test.world:tickEntity(thfMob)
        end,

        expected =
        {
            m_uID   = ph.IGNORE,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MOBABILITY_FINISH,
            cmd_arg = xi.jobSpecialAbility.PERFECT_DODGE,
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
                            kind      = 3,
                            sub_kind  = 434,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.PERFECT_DODGE,
                            message   = xi.msg.basic.USES,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Mob buffing self + ally (MobSkillFinish)'] =
    {
        test = function(player, mob)
            player:gotoZone(xi.zone.DYNAMIS_SAN_DORIA)
            local thfMob = player.entities:moveTo('Vanguard_Pillager')
            thfMob:useMobAbility(xi.mobSkill.HOWL, thfMob, 0)
            xi.test.world:tickEntity(thfMob)
            xi.test.world:skipTime(10)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            m_uID   = ph.IGNORE,
            trg_sum = ph.IGNORE,
            res_sum = 0,
            cmd_no  = xi.action.category.MOBABILITY_FINISH,
            cmd_arg = xi.mobSkill.HOWL,
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
                            kind      = 3,
                            sub_kind  = 354,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.WARCRY,
                            message   = xi.msg.basic.SKILL_GAIN_EFFECT, -- TODO: Retail accurate is 194
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
                            kind      = 3,
                            sub_kind  = 354,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.WARCRY,
                            message   = xi.msg.basic.JA_GAIN_EFFECT, -- TODO: Retail accurate is 280
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Ruszor self miss sequence (MobSkillFinish)'] =
    {
        test = function(player, mob)
            -- Ruszor always complete their skill, even if no one is in damage range.
            player:gotoZone(xi.zone.BEAUCEDINE_GLACIER_S)
            local ruszor = player.entities:moveTo('Ruszor')
            ruszor:updateEnmity(player)
            ruszor:useMobAbility(xi.mobSkill.HYDRO_WAVE, player, 6)
            xi.test.world:tickEntity(ruszor)
            -- Move player far away so Hydro Wave has no targets in range
            player.actions:move(ruszor:getXPos() + 20, ruszor:getYPos(), ruszor:getZPos())
            xi.test.world:tickEntity(ruszor)
            xi.test.world:skipTime(10)
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
                                value     = xi.mobSkill.HYDRO_WAVE,
                                message   = xi.msg.basic.READIES_SKILL,
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
                cmd_no  = xi.action.category.MOBABILITY_FINISH,
                cmd_arg = xi.mobSkill.HYDRO_WAVE,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = xi.action.resolution.MISS,
                                kind      = 3,
                                sub_kind  = 1701,
                                info      = 4,
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
            --             { -- TODO: LSB is not emitting this extra spte packet
            --                 m_uID   = ph.IGNORE,
            --                 trg_sum = 1,
            --                 res_sum = 0,
            --                 cmd_no  = xi.action.category.WEAPONSKILL_START,
            --                 cmd_arg = xi.action.fourCC.SKILL_INTERRUPT,
            --                 info    = 0,
            --                 target  =
            --                 {
            --                     {
            --                         m_uID      = ph.IGNORE,
            --                         result_sum = 1,
            --                         result     =
            --                         {
            --                             {
            --                                 miss          = 0,
            --                                 kind          = 0,
            --                                 sub_kind      = 0,
            --                                 info          = 0,
            --                                 scale         = 0,
            --                                 value         = 0,
            --                                 message       = 0,
            --                                 bit           = 0,
            --                                 has_proc      = false,
            --                                 proc_kind     = 0,
            --                                 proc_info     = 0,
            --                                 proc_value    = 0,
            --                                 proc_message  = 0,
            --                                 has_react     = false,
            --                                 react_kind    = 0,
            --                                 react_info    = 0,
            --                                 react_value   = 0,
            --                                 react_message = 0,
            --                             },
            --                         },
            --                     },
            --                 },
            --             },
        },
    },
    ['Sweep no valid target in range'] =
    {
        test = function(player, mob)
            player:gotoZone(xi.zone.DYNAMIS_WINDURST)
            local yagudo = player.entities:moveTo('Vanguard_Chanter')
            yagudo:updateEnmity(player)
            yagudo:addTP(3000)
            yagudo:useMobAbility(xi.mobSkill.SWEEP, player, 5, true)
            -- Move player far away so Sweep has no targets in range
            player.actions:move(yagudo:getXPos() + 25, yagudo:getYPos(), yagudo:getZPos())
            xi.test.world:tickEntity(yagudo)
            xi.test.world:skipTime(10)
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
                                value     = xi.mobSkill.SWEEP,
                                message   = xi.msg.basic.READIES_SKILL,
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
                                message   = xi.msg.basic.NO_TARG_IN_AOE,
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
    ['Mob dies mid-ready'] =
    {
        test = function(player)
            local mob = player.entities:moveTo('Clipper')
            mob:useMobAbility(xi.mobSkill.BIG_SCISSORS, player, 10)
            xi.test.world:tickEntity(mob)
            mob:setHP(0)              -- Kill mob while in "ready" state
            xi.test.world:skipTime(3) -- Process death and interrupt
        end,

        expected =
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
    },
    ['Knockback'] =
    {
        test = function(player, mob)
            player:gotoZone(xi.zone.BEAUCEDINE_GLACIER_S)
            local ruszor = player.entities:moveTo('Ruszor')
            ruszor:updateEnmity(player)
            ruszor:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 0)
            xi.test.world:tickEntity(ruszor)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            m_uID   = ph.IGNORE,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MOBABILITY_FINISH,
            cmd_arg = xi.mobSkill.AQUA_BLAST,
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
                            sub_kind  = 1699,
                            info      = 0,
                            scale     = 20, -- This is knockback 5 (3 bits)
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
}

return packets
