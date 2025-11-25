local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Players spikes'] =
    {
        test = function(player, mob)
            player:setLevel(1)
            player:setUnkillable(true)
            player:setMod(xi.mod.SPIKES, xi.subEffect.BLAZE_SPIKES)
            mob:updateEnmity(player)
            for i = 1, 10 do
                -- Tick the AI several times to process basic attacks
                xi.test.world:tickEntity(mob)
                xi.test.world:skipTime(5)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_MOB,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.BASIC_ATTACK,
            cmd_arg = xi.action.fourCC.ATTACK,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss          = 0,
                            kind          = 1,
                            sub_kind      = 0,
                            info          = ph.IGNORE,
                            scale         = ph.IGNORE,
                            value         = ph.IGNORE,
                            message       = ph.IGNORE,
                            bit           = 0,
                            has_proc      = false,
                            has_react     = true,
                            react_kind    = xi.subEffect.BLAZE_SPIKES,
                            react_info    = 0,
                            react_value   = ph.IGNORE,
                            react_message = xi.msg.basic.SPIKES_EFFECT_DMG,
                        },
                    },
                },
            },
        },
    },
    ['Triple attack'] =
    {
        test = function(player, mob)
            player:setLevel(1)
            player:setUnkillable(true)
            mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
            mob:updateEnmity(player)
            for i = 1, 100 do
                -- Tick the AI several times to process basic attacks
                xi.test.world:tickEntity(mob)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_MOB,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.BASIC_ATTACK,
            cmd_arg = xi.action.fourCC.ATTACK,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.TEST_CHAR,
                    result_sum = 3,
                    result     =
                    {
                        {
                            miss      = 0,
                            kind      = 1,
                            sub_kind  = 0,
                            info      = ph.IGNORE,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = ph.IGNORE,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                        {
                            miss      = 0,
                            kind      = 1,
                            sub_kind  = 0,
                            info      = ph.IGNORE,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = ph.IGNORE,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                        {
                            miss      = 0,
                            kind      = 1,
                            sub_kind  = 0,
                            info      = ph.IGNORE,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = ph.IGNORE,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Parried hits'] =
    {
        test = function(player, mob)
            stub('xi.combat.physical.isParried', true)
            player:gotoZone(xi.zone.DYNAMIS_SAN_DORIA)
            player:changeJob(xi.job.BRD)
            player:setLevel(99)
            player:setMod(xi.mod.ACC, 1000)
            player:addItem(xi.item.BRONZE_DAGGER)
            player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
            local warMob = player.entities:moveTo('Vanguard_Footsoldier')
            player.actions:engage(warMob)
            for i = 1, 20 do
                xi.test.world:tickEntity(player)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.BASIC_ATTACK,
            cmd_arg = xi.action.fourCC.ATTACK,
            info    = 0,
            target  =
            {
                {
                    m_uID      = ph.IGNORE,
                    result_sum = 1,
                    result     =
                    {
                        {
                            miss      = xi.action.resolution.PARRY,
                            kind      = 1,
                            sub_kind  = 0,
                            info      = 0,
                            scale     = 0,
                            value     = 0,
                            message   = xi.msg.basic.PARRIED,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Guarded hits'] =
    {
        test = function(player, mob)
            player:gotoZone(xi.zone.DYNAMIS_SAN_DORIA)
            player:changeJob(xi.job.BRD)
            player:setLevel(99)
            player:setMod(xi.mod.ACC, 1000)
            player:addItem(xi.item.BRONZE_DAGGER)
            player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
            local mnkMob = player.entities:moveTo('Vanguard_Grappler')
            -- Not all paths use the lua function? Need the MOD for now.
            stub('xi.combat.physical.isGuarded', true)
            mnkMob:setMod(xi.mod.ADDITIVE_GUARD, 100)

            player.actions:engage(mnkMob)
            for i = 1, 20 do
                xi.test.world:tickEntity(player)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_CHAR,
            trg_sum = 1,
            res_sum = 0,
            cmd_no  = xi.action.category.BASIC_ATTACK,
            cmd_arg = xi.action.fourCC.ATTACK,
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
                            kind      = 1,
                            sub_kind  = 0,
                            info      = ph.IGNORE,
                            scale     = ph.IGNORE,
                            value     = ph.IGNORE,
                            message   = 1,
                            bit       = 0,
                            has_proc  = false,
                            has_react = false,
                        },
                    },
                },
            },
        },
    },
    ['Basic Attack paralyzed'] =
    {
        test = function(player, mob)
            mob:setMod(xi.mod.PARALYZE, 100)
            mob:updateEnmity(player)
            for i = 1, 20 do
                xi.test.world:tickEntity(mob)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_MOB,
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
    ['Intimidated basic attack'] =
    {
        test = function(player, mob)
            player:setMod(xi.mod.AQUAN_KILLER, 100)
            mob:updateEnmity(player)
            for i = 1, 20 do
                xi.test.world:tickEntity(mob)
                xi.test.world:skipTime(10)
            end
        end,

        expected =
        {
            m_uID   = ph.TEST_MOB,
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
                            message   = xi.msg.basic.IS_INTIMIDATED,
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
