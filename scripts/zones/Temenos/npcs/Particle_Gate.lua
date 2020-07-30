-----------------------------------
-- Area: Temenos
-- NPC:  Particle_Gate
-----------------------------------

require("scripts/globals/limbus")
require("scripts/globals/keyitems")

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player, npc, trade)
end

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player, npc)
    local GateID =  npc:getID()

    -- print("GateID " ..GateID)
    -- player:PrintToPlayer(npc:getID())

    switch (GateID): caseof
    {
         -- 100-106 : Northern Tower
        [GATE_OFFSET] = function (x)
             player:startEvent(100)
        end,
        [GATE_OFFSET+1] = function (x)
             player:startEvent(101)
        end,
        [GATE_OFFSET+2] = function (x)
             player:startEvent(102)
        end,
        [GATE_OFFSET+3] = function (x)
             player:startEvent(103)
        end,
        [GATE_OFFSET+4] = function (x)
             player:startEvent(104)
        end,
        [GATE_OFFSET+5] = function (x)
             player:startEvent(105)
        end,
        [GATE_OFFSET+6] = function (x)
             player:startEvent(106)
        end,
        -- 107-113 : Eastern Tower
        [GATE_OFFSET+7] = function (x)
             player:startEvent(107)
        end,
        [GATE_OFFSET+8] = function (x)
             player:startEvent(108)
        end,
        [GATE_OFFSET+9] = function (x)
             player:startEvent(109)
        end,
        [GATE_OFFSET+10] = function (x)
             player:startEvent(110)
        end,
        [GATE_OFFSET+11] = function (x)
             player:startEvent(111)
        end,
        [GATE_OFFSET+12] = function (x)
             player:startEvent(112)
        end,
        [GATE_OFFSET+13] = function (x)
             player:startEvent(113)
        end,
        -- 114-120 Western Tower
        [GATE_OFFSET+14] = function (x)
             player:startEvent(114)
        end,
        [GATE_OFFSET+15] = function (x)
             player:startEvent(115)
        end,
        [GATE_OFFSET+16] = function (x)
             player:startEvent(116)
        end,
        [GATE_OFFSET+17] = function (x)
             player:startEvent(117)
        end,
        [GATE_OFFSET+18] = function (x)
             player:startEvent(118)
        end,
        [GATE_OFFSET+19] = function (x)
             player:startEvent(119)
        end,
        [GATE_OFFSET+20] = function (x)
             player:startEvent(120)
        end,
        -- The rest of Temenos
        [GATE_OFFSET+21] = function (x)
             player:startEvent(120)
        end,
        [GATE_OFFSET+22] = function (x)
             player:startEvent(120)
        end,
        [GATE_OFFSET+23] = function (x)
             player:startEvent(120)
        end,
        [GATE_OFFSET+24] = function (x)
             player:startEvent(120)
        end,
        [GATE_OFFSET+25] = function (x)
             player:startEvent(120)
        end,
    }
end

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player, csid, option)
end

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player, csid, option)
-- printf("CSID: %u", csid)
-- printf("RESULT: %u", option)
end
