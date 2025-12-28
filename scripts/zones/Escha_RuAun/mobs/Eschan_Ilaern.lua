-----------------------------------
-- Area: Escha Ru'Aun
--  Mob: Eschan Ilaern
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Eschan_Ilaerns_Spirit')
    xi.pet.setMobPet(mob, 1, 'Eschan_Ilaerns_Euvhi')
    xi.pet.setMobPet(mob, 1, 'Eschan_Ilaerns_Wynav')
end

return entity
