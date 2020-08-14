-----------------------------------------
-- ID: 11538
-- Item: Nexus Cape
-- Enchantment: "Teleport" (Party Leader)
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = tpz.msg.basic.ITEM_UNABLE_TO_USE -- Default is fail.
    local leader = target:getPartyLeader()
    -- In a party and we were able to find the leader
    -- (currently fails in cross map server situations)
    if leader ~= nil and not leader:isInMogHouse() then
        -- Don't try to teleport to self!
        if (target:getID() ~= leader:getID()) then
            local leaderZone = leader:getZoneID()
            local validZoneList =
            {
                5, 7, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114,
                115, 116, 117, 118, 119, 120, 123, 124, 125, 126, 127, 128, 230, 231, 232, 234,
                235, 236, 238, 239, 240, 241, 243, 244, 245, 246, 247, 248, 249, 250, 252, 257
            }
            -- Make sure we can actually tele to that zone..
            for _, validZone in ipairs(validZoneList) do
                if validZone == leaderZone then
                    result = 0
                end
            end
        end
    end

    return result
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.LEADER, 0, 1)
end
