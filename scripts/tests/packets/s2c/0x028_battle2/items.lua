local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Interrupted'] =
    {
        test = function(player, mob)
            player:addItem(xi.item.TOOLBAG_SHIHEI)
            local toolbag = player:findItem(xi.item.TOOLBAG_SHIHEI)
            assert(toolbag, 'Could not find toolbag')
            player.actions:useItem(player, toolbag:getSlotID())
            xi.test.world:tickEntity(player)
            player.actions:move(10, 10, 10)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.ITEM_START,
                cmd_arg = xi.action.fourCC.ITEM_USE,
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
                                value     = xi.item.TOOLBAG_SHIHEI,
                                message   = xi.msg.basic.ITEM_USES,
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
                cmd_no  = xi.action.category.ITEM_START,
                cmd_arg = xi.action.fourCC.ITEM_INTERRUPT,
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
        },
    },
    ['Paralyzed'] =
    {
        test = function(player, mob)
            player:addItem(xi.item.TOOLBAG_SHIHEI)
            player:setMod(xi.mod.PARALYZE, 100)
            local toolbag = player:findItem(xi.item.TOOLBAG_SHIHEI)
            assert(toolbag, 'Could not find toolbag')
            player.actions:useItem(player, toolbag:getSlotID())
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.ITEM_START,
                cmd_arg = xi.action.fourCC.ITEM_USE,
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
                                value     = xi.item.TOOLBAG_SHIHEI,
                                message   = xi.msg.basic.ITEM_USES,
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
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.ITEM_START,
                cmd_arg = xi.action.fourCC.ITEM_INTERRUPT,
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
        },
    },
    ['Use'] =
    {
        test = function(player, mob)
            player:addItem(xi.item.TOOLBAG_SHIHEI)
            local toolbag = player:findItem(xi.item.TOOLBAG_SHIHEI)
            assert(toolbag, 'Could not find toolbag')
            player.actions:useItem(player, toolbag:getSlotID())
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
            player.assert:hasItem(xi.item.SHIHEI)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.ITEM_START,
                cmd_arg = xi.action.fourCC.ITEM_USE,
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
                                value     = xi.item.TOOLBAG_SHIHEI,
                                message   = xi.msg.basic.ITEM_USES,
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
                cmd_no  = xi.action.category.ITEM_FINISH,
                cmd_arg = xi.item.TOOLBAG_SHIHEI,
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
                                kind      = 1,
                                sub_kind  = 55,
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
    ['AoE item'] =
    {
        test = function(player, mob)
            local p2 = xi.test.world:spawnPlayer({ zone = xi.zone.QUFIM_ISLAND })
            player.actions:inviteToParty(p2)
            p2.actions:acceptPartyInvite()
            player:setPos(100, 0, 100)
            p2:setPos(102, 0, 102)
            player:addItem(xi.item.HOMEMADE_SALISBURY_STEAK)
            local food = player:findItem(xi.item.HOMEMADE_SALISBURY_STEAK)
            assert(food, 'Could not find food')
            player.actions:useItem(player, food:getSlotID())
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.ITEM_START,
                cmd_arg = xi.action.fourCC.ITEM_USE,
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
                                value     = xi.item.HOMEMADE_SALISBURY_STEAK,
                                message   = xi.msg.basic.ITEM_USES,
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
                trg_sum = 2,
                res_sum = 0,
                cmd_no  = xi.action.category.ITEM_FINISH,
                cmd_arg = xi.item.HOMEMADE_SALISBURY_STEAK,
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
                                kind      = 1,
                                sub_kind  = 28,
                                info      = 0,
                                scale     = 0,
                                value     = xi.effect.FOOD,
                                message   = 0,
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
                                kind      = 1,
                                sub_kind  = 28,
                                info      = 0,
                                scale     = 0,
                                value     = xi.effect.FOOD,
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
