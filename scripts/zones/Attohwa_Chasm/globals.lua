-----------------------------------
-- Zone: Attohwa_Chasm
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------

local attohwaChasmGlobal =
{
    -- Check to see if any mobs associated with Feeler Antlion are still spawned
    -- if not then can start the timer to respawn the ???; a custom function is needed
    -- because npcUtil.popFromQM does not support ??? timer when mobs pop other mobs
    canStartFeelerQMTimer = function(despawningMobID)
        -- assume true that none of the mobs are spawned
        local canStartTimer = true

        -- first check feeler and alastor to make sure not spawned
        local feeler = GetMobByID(ID.mob.FEELER_ANTLION)
        local alastor = GetMobByID(ID.mob.ALASTOR_ANTLION)
        if (feeler and feeler:isSpawned()) or (alastor and alastor:isSpawned()) then
            canStartTimer = false
        end

        -- then check all executioners to make sure not spawned
        for _, executionerID in ipairs(ID.mob.EXECUTIONER_ANTLION) do
            local executioner = GetMobByID(executionerID)
            if executioner and executioner:isSpawned() then
                canStartTimer = false
                break
            end
        end

        return canStartTimer
    end,

    handleMiasma = function(npc)
        local timer    = npc:getLocalVar('timer')
        local newTimer = math.randomInt(30, 40)

        if GetSystemTime() >= timer then
            if npc:getAnimation() == xi.animation.CLOSE_DOOR then
                npc:setAnimation(xi.animation.OPEN_DOOR)
            else
                npc:setAnimation(xi.animation.CLOSE_DOOR)
            end

            npc:setLocalVar('timer', GetSystemTime() + newTimer)
        end
    end,

    handleLuminantUsed = function(npc)
        npc:setStatus(xi.status.CUTSCENE_ONLY)

        -- Reactivate a random deactivated luminant after 30-60 minutes
        -- Because 3 luminants always start activated when the server starts,
        -- the luminants will always be restored back to 3 active eventually.
        npc:timer(math.randomInt(1800, 3600), function()
            local luminantTable = ID.npc.LUMINANT
            local shuffledTable = utils.shuffle(luminantTable) -- Reorder the luminantTable randomly.
            for _, luminantId in ipairs(shuffledTable) do
                local luminant = GetNPCByID(luminantId)
                if
                    luminant and
                    luminant:getStatus() == xi.status.CUTSCENE_ONLY
                then
                    luminant:setStatus(xi.status.NORMAL)
                    break
                end
            end
        end)
    end,

    removeMimeoKIs = function(player)
        if player:hasKeyItem(xi.ki.MIMEO_STONE) then
            player:delKeyItem(xi.ki.MIMEO_STONE)
            player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_STONE)
        end

        if player:hasKeyItem(xi.ki.MIMEO_JEWEL) then
            player:delKeyItem(xi.ki.MIMEO_JEWEL)
            player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_JEWEL)
        end
    end,
}

return attohwaChasmGlobal
