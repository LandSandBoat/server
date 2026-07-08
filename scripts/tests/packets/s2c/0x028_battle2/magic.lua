local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Cure Self (Interrupt)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.WHM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.CURE_IV)
            player.actions:useSpell(player, xi.magic.spell.CURE_IV)
            xi.test.world:tickEntity(player) -- Start the cast
            player.actions:move(10, 10, 10)
            xi.test.world:skipTime(10)       -- Let cast complete for interrupt to process
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MAGIC_START,
            cmd_arg = xi.action.fourCC.WHITE_MAGIC_INTERRUPT,
            info    = 0, -- Retail uncleared buffer
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.HIT,
                            kind      = 0, -- Retail uncleared buffer
                            sub_kind  = 0, -- Retail uncleared buffer
                            info      = 0, -- Retail uncleared buffer
                            scale     = 0,
                            value     = xi.magic.spell.CURE_IV,
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
    ['Cure Self'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.WHM)
            player:setLevel(99)
            player:setHP(player:getMaxHP())
            player:addSpell(xi.magic.spell.CURE)
            player.actions:useSpell(player, xi.magic.spell.CURE)
            xi.test.world:skipTime(10) -- Let it complete the cast and tick the AI
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_START,
                cmd_arg = xi.action.fourCC.WHITE_MAGIC_CAST,
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
                                kind      = 0, -- Retail has uncleared data here
                                sub_kind  = 0, -- Retail has uncleared data here
                                info      = 0, -- Retail has uncleared data here
                                scale     = 0,
                                value     = xi.magic.spell.CURE,
                                message   = xi.msg.basic.MAGIC_STARTS_CASTING_TARGET,
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
                cmd_arg = xi.magic.spell.CURE,
                info    = 5, -- Recast
                target  =
                {
                    {
                        m_uID      = ph.TEST_CHAR,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = xi.action.resolution.HIT,
                                kind      = 0,
                                sub_kind  = xi.magic.spell.CURE,
                                info      = 0,
                                scale     = 0,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.MAGIC_RECOVERS_HP,
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
    ['Stoneskin Self (Hit)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RDM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.STONESKIN)
            player.actions:useSpell(player, xi.magic.spell.STONESKIN)
            xi.test.world:skipTime(10) -- Let it complete the cast and tick the AI
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MAGIC_FINISH,
            cmd_arg = xi.magic.spell.STONESKIN,
            info    = 25, -- Recast
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.HIT,
                            kind      = 0,
                            sub_kind  = xi.magic.spell.STONESKIN,
                            info      = 0,
                            scale     = 0,
                            value     = xi.effect.STONESKIN,
                            message   = xi.msg.basic.MAGIC_GAIN_EFFECT,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Stoneskin Self (Miss)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RDM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.STONESKIN)
            player.actions:useSpell(player, xi.magic.spell.STONESKIN)
            xi.test.world:skipTime(10) -- Let it complete the cast and tick the AI
            xi.test.world:skipTime(30) -- Wait for recast
            player.actions:useSpell(player, xi.magic.spell.STONESKIN)
            xi.test.world:skipTime(10) -- Let it complete the cast and tick the AI
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MAGIC_FINISH,
            cmd_arg = xi.magic.spell.STONESKIN,
            info    = 25, -- Recast
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.MISS,
                            kind      = 0,
                            sub_kind  = xi.magic.spell.STONESKIN,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = xi.msg.basic.MAGIC_NO_EFFECT,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Head Butt'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.BLU)
            player:setLevel(99)
            player:setSkillLevel(xi.skill.BLUE_MAGIC, 424)
            player:addSpell(xi.magic.spell.HEAD_BUTT)
            player.actions:setBlueSpells({ xi.magic.spell.HEAD_BUTT })
            player:resetRecasts()
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            mob:updateClaim(player)
            mob:setMaxHP(1)
            mob:setHP(1)
            player.actions:useSpell(mob, xi.magic.spell.HEAD_BUTT)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MAGIC_FINISH,
            cmd_arg = xi.magic.spell.HEAD_BUTT,
            info    = ph.IGNORE,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss          = xi.action.resolution.HIT,
                            kind          = 0,
                            sub_kind      = 665,
                            info          = xi.action.info.DEFEATED,
                            scale         = 7, -- This is heavy hit distortion (2 bits) + knockback 1 (3 bits)
                            value         = ph.IGNORE,
                            message       = xi.msg.basic.MAGIC_DMG,
                            bit           = 0,
                            has_proc      = false,
                            proc_kind     = 0,
                            proc_info     = 0,
                            proc_value    = 0,
                            proc_message  = 0,
                            has_react     = false,
                            react_kind    = 0,
                            react_info    = 0,
                            react_value   = 0,
                            react_message = 0,
                        },
                    },
                },
            },
        },
    },
    ['Regurgitation'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.BLU)
            player:setLevel(99)
            player:setSkillLevel(xi.skill.BLUE_MAGIC, 424)
            player:addSpell(xi.magic.spell.REGURGITATION)
            player.actions:setBlueSpells({ xi.magic.spell.REGURGITATION })
            player:resetRecasts()
            mob:setUnkillable(true)
            player.actions:useSpell(mob, xi.magic.spell.REGURGITATION)
            xi.test.world:skipTime(10)
            mob:setUnkillable(false)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.MAGIC_FINISH,
            cmd_arg = xi.magic.spell.REGURGITATION,
            info    = ph.IGNORE,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss          = xi.action.resolution.HIT,
                            kind          = 0,
                            sub_kind      = 770,
                            info          = 0,
                            scale         = 12, -- This is knockback 3 (3 bits), with no hit distortion
                            value         = ph.IGNORE,
                            message       = xi.msg.basic.MAGIC_DMG,
                            bit           = 0,
                            has_proc      = false,
                            proc_kind     = 0,
                            proc_info     = 0,
                            proc_value    = 0,
                            proc_message  = 0,
                            has_react     = false,
                            react_kind    = 0,
                            react_info    = 0,
                            react_value   = 0,
                            react_message = 0,
                        },
                    },
                },
            },
        },
    },
    ['Paralyzed'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.WHM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.CURE)
            player:setMod(xi.mod.PARALYZE, 100)
            player.actions:useSpell(player, xi.magic.spell.CURE)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_START,
                cmd_arg = xi.action.fourCC.WHITE_MAGIC_CAST,
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
                                value     = xi.magic.spell.CURE,
                                message   = xi.msg.basic.MAGIC_STARTS_CASTING_TARGET,
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
                cmd_arg = xi.magic.spell.CURE,
                info    = 2,
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
                cmd_no  = xi.action.category.MAGIC_START,
                cmd_arg = xi.action.fourCC.WHITE_MAGIC_INTERRUPT,
                info    = 0, -- Retail has 2 here but likely from uncleared buffer
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
                                value     = xi.magic.spell.CURE,
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
    ['Intimidated'] =
    {
        test = function(player, mob)
            mob:setMod(xi.mod.HUMANOID_KILLER, 100)
            player:changeJob(xi.job.WHM)
            player:addSpell(xi.magic.spell.DIA)
            player.actions:useSpell(mob, xi.magic.spell.DIA)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_START,
                cmd_arg = xi.action.fourCC.WHITE_MAGIC_CAST,
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
                                value     = xi.magic.spell.DIA,
                                message   = xi.msg.basic.MAGIC_STARTS_CASTING_TARGET,
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
                cmd_arg = xi.magic.spell.DIA,
                info    = 2,
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
                                message   = xi.msg.basic.IS_INTIMIDATED,
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
                cmd_no  = xi.action.category.MAGIC_START,
                cmd_arg = xi.action.fourCC.WHITE_MAGIC_INTERRUPT,
                info    = 0, -- 2 on retail but likely from uncleared buffers
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
                                value     = xi.magic.spell.DIA,
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
