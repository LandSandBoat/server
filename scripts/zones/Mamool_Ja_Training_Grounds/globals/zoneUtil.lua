-----------------------------------
-- Zone Utilities
-- random globals that may be used per zone
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
-----------------------------------
local zoneUtil = {}

function zoneUtil.ImperialAgent_PotHatch(player, npc, posX, posZ, posR)
    local instance = npc:getInstance()

    npc:setAnimation(8)

    if npc:getID() == instance:getProgress() then
        local BRUJEEL = GetNPCByID(ID.npc.BRUJEEL, instance)
        local chars = instance:getChars()

        instance:setProgress(0)
        for _,v in pairs(chars) do
            npc:timer(2000, function(npc) BRUJEEL:setPos(posX, -1, posZ, posR)
            BRUJEEL:setStatus(xi.status.NORMAL) BRUJEEL:entityAnimationPacket("deru") end)
            npc:timer(4000, function(npc) BRUJEEL:setAnimation(0) end)
            player:timer(7000, function(player) v:showText(BRUJEEL, ID.text.BRUJEEL_TEXT) end)
            player:timer(10000, function(player) v:showText(BRUJEEL, ID.text.BRUJEEL_TEXT + 1) end)
            player:timer(12000, function(player) v:showText(BRUJEEL, ID.text.BRUJEEL_TEXT + 2) end)
            player:timer(14000, function(player) v:showText(BRUJEEL, ID.text.BRUJEEL_TEXT + 3) end)
            player:timer(16000, function(player) v:showText(BRUJEEL, ID.text.BRUJEEL_TEXT + 4) end)
            player:timer(18000, function(player) v:showText(BRUJEEL, ID.text.BRUJEEL_TEXT + 5) end)
            npc:timer(20000, function(npc) BRUJEEL:entityAnimationPacket("cabk") end)
            npc:timer(22000, function(npc) BRUJEEL:entityAnimationPacket("shbk") end)
            npc:timer(23000, function(npc) BRUJEEL:entityAnimationPacket("kesu") end)
            npc:timer(24500, function(npc) BRUJEEL:setStatus(xi.status.DISAPPEAR) end)
            npc:timer(26000, function(npc) instance:complete() end)
        end
    end
end

return zoneUtil
