-----------------------------------
-- Area: Temenos E T
--  Mob: Mystic Avatar
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, -128)
    end
end

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+2):updateEnmity(target)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+1):updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        if mobID <= ID.mob.TEMENOS_E_MOB[6] + 4 then
            local floor = ((mobID - (ID.mob.TEMENOS_E_MOB[1] + 4)) / 9) + 1
            local crateMask = battlefield:getLocalVar("crateMaskF" .. floor)
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[floor])
            end
        elseif mobID >= ID.mob.TEMENOS_C_MOB[2]+9 then
            local element_offset = mobID - ID.mob.TEMENOS_C_MOB[2]+8
            local partner_offset = element_offset % 6 -- Levithan's partner starts at 0
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.FIREDEF - 1 + element_offset)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2] + 3 + partner_offset):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2] + 3 + partner_offset)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2] + 9 + partner_offset)
            end
        end

    end
end
