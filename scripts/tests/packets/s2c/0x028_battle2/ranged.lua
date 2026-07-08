local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Ranged Attack Start (Ranged Start)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:addItem(xi.item.MARTIAL_GUN)
            player:addItem(xi.item.SILVER_BULLET)
            player:equipItem(xi.item.MARTIAL_GUN)
            player:equipItem(xi.item.SILVER_BULLET)
            player.actions:engage(mob)
            player.actions:rangedAttack(mob)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RANGED_START,
            cmd_arg = xi.action.fourCC.RANGE_START,
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
                            kind      = 0,
                            sub_kind  = 0, -- Retail has garbage here
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
    ['Ranged Attack Finish (Ranged Finish)'] =
    {
        test = function(player, mob)
            stub('xi.combat.ranged.attackDistancePenalty', 14)
            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:setMod(xi.mod.RACC, 1000)
            player:addItem(xi.item.POWER_BOW)
            player:addItem(xi.item.WOODEN_ARROW, 99)
            player:equipItem(xi.item.POWER_BOW)
            player:equipItem(xi.item.WOODEN_ARROW)
            player.actions:engage(mob)
            for i = 1, 10 do
                player.actions:rangedAttack(mob)
                xi.test.world:skipTime(10)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RANGED_FINISH,
            cmd_arg = xi.action.fourCC.RANGE_FINISH,
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
                            sub_kind  = 0,
                            info      = ph.IGNORE,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = ph.IGNORE, -- This might be a miss, we just want to know the action completed
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Ranged Attack Interrupt (Ranged Start)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:addItem(xi.item.POWER_BOW)
            player:addItem(xi.item.WOODEN_ARROW)
            player:equipItem(xi.item.POWER_BOW)
            player:equipItem(xi.item.WOODEN_ARROW)
            player.actions:engage(mob)
            player.actions:rangedAttack(mob)
            xi.test.world:tickEntity(player) -- Start shooting
            player.actions:move(30, 30, 30)
            xi.test.world:skipTime(10)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RANGED_START,
            cmd_arg = xi.action.fourCC.RANGE_INTERRUPT,
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
    ['Ranged Attack Finish (Critical Hit)'] =
    {
        test = function(player, mob)
            stub('xi.combat.ranged.attackDistancePenalty', 14)
            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:setMod(xi.mod.RACC, 1000)
            player:setMod(xi.mod.RATTP, 1000)
            player:setMod(xi.mod.CRITHITRATE, 100)
            player:addItem(xi.item.YOICHINOYUMI_119)
            player:addItem(xi.item.RUSZOR_ARROW, 99)
            player:equipItem(xi.item.YOICHINOYUMI_119)
            player:equipItem(xi.item.RUSZOR_ARROW)
            player.actions:engage(mob)
            for i = 1, 5 do
                player.actions:rangedAttack(mob)
                xi.test.world:skipTime(10)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RANGED_FINISH,
            cmd_arg = xi.action.fourCC.RANGE_FINISH,
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
                            sub_kind  = 0,
                            info      = 3, -- Crit + Defeated
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = xi.msg.basic.RANGED_ATTACK_CRIT,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Ranged Attack Miss (Ranged Finish)'] =
    {
        test = function(player, mob)
            stub('xi.combat.ranged.attackDistancePenalty', 14)
            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:addItem(xi.item.POWER_BOW)
            player:addItem(xi.item.WOODEN_ARROW)
            player:equipItem(xi.item.POWER_BOW)
            player:equipItem(xi.item.WOODEN_ARROW)
            player.actions:engage(mob)
            player.actions:rangedAttack(mob)
            xi.test.world:skipTime(1) -- Let ranged attack start
            mob:setPos(90, 90, 90)    -- Move the mob to be beyond the 25 yalms limit
            xi.test.world:skipTime(10)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RANGED_FINISH,
            cmd_arg = xi.action.fourCC.RANGE_FINISH,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_MOB,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.MISS,
                            kind      = 2,
                            sub_kind  = 0,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = xi.msg.basic.RANGED_ATTACK_MISS,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Ranged with added effect (Ranged Finish)'] =
    {
        test = function(player, mob)
            -- Force AE to proc
            stub('xi.additionalEffect.attack', function(attacker, defender, baseAttackDamage, item)
                return xi.subEffect.SILENCE, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.SILENCE
            end)

            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:setMod(xi.mod.RACC, 1000)
            player:addItem(xi.item.POWER_BOW)
            player:addItem(xi.item.KABURA_ARROW, 99)
            player:equipItem(xi.item.POWER_BOW)
            player:equipItem(xi.item.KABURA_ARROW)
            player.actions:engage(mob)
            for i = 1, 10 do
                player.actions:rangedAttack(mob)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.RANGED_FINISH,
            cmd_arg = xi.action.fourCC.RANGE_FINISH,
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
                            kind         = 2,
                            sub_kind     = 0,
                            info         = ph.IGNORE,
                            scale        = ph.IGNORE,
                            value        = ph.IGNORE,
                            message      = ph.IGNORE,
                            bit          = 0,
                            has_proc     = true,
                            proc_kind    = xi.subEffect.SILENCE,
                            proc_info    = 0,
                            proc_value   = xi.effect.SILENCE,
                            proc_message = xi.msg.basic.ADD_EFFECT_STATUS,
                            has_react    = false,

                        },
                    },
                },
            },
        },
    },
    ['Ranged Paralyzed'] =
    {
        test = function(player, mob)
            player:addItem(xi.item.LAMIABANE)
            player:equipItem(xi.item.LAMIABANE)
            player:setMod(xi.mod.PARALYZE, 100)
            player.actions:engage(mob)
            player.actions:rangedAttack(mob)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.RANGED_START,
                cmd_arg = xi.action.fourCC.RANGE_START,
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
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.RANGED_START,
                cmd_arg = xi.action.fourCC.RANGE_INTERRUPT,
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
        },
    },
}

return packets
