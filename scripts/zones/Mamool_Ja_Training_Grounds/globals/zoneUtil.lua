-----------------------------------
-- Zone Utilities
-- random globals that may be used per zone
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
-----------------------------------
xi = xi or {}
xi.zoneUtil = xi.zoneUtil or {}
-----------------------------------

xi.zoneUtil.ImperialAgent_PotHatch = function(player, npc, posX, posZ, posR)
    local instance = npc:getInstance()

    npc:setAnimation(8)

    if npc:getID() == instance:getProgress() then
        local ally = GetNPCByID(ID.npc.BRUJEEL, instance)

        instance:setProgress(0)
        npc:timer(2000, function(npcArg)
            ally:setPos(posX, -1, posZ, posR)
            ally:setStatus(xi.status.NORMAL)
            ally:entityAnimationPacket("deru")
        end)

        npc:timer(4000, function(npcArg)
            ally:setAnimation(0)
        end)

        npc:timer(7000, function(npcArg)
            ally:showText(ally, ID.text.BRUJEEL_TEXT)
        end)

        npc:timer(10000, function(npcArg)
            ally:showText(ally, ID.text.BRUJEEL_TEXT + 1)
        end)

        npc:timer(12000, function(npcArg)
            ally:showText(ally, ID.text.BRUJEEL_TEXT + 2)
        end)

        npc:timer(14000, function(npcArg)
            ally:showText(ally, ID.text.BRUJEEL_TEXT + 3)
        end)

        npc:timer(16000, function(npcArg)
            ally:showText(ally, ID.text.BRUJEEL_TEXT + 4)
        end)

        npc:timer(18000, function(npcArg)
            ally:showText(ally, ID.text.BRUJEEL_TEXT + 5)
        end)

        npc:timer(20000, function(npcArg)
            ally:entityAnimationPacket("cabk")
        end)

        npc:timer(22000, function(npcArg)
            ally:entityAnimationPacket("shbk")
        end)

        npc:timer(23000, function(npcArg)
            ally:entityAnimationPacket("kesu")
        end)

        npc:timer(24500, function(npcArg)
            ally:setStatus(xi.status.DISAPPEAR)
        end)

        npc:timer(26000, function(npcArg)
            instance:complete()
        end)
    end
end
