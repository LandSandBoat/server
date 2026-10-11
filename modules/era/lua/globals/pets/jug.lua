-----------------------------------
-- Module: Jug Pet Adjustments
-- Description: Various overrides for jug pet related changes.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_jugpet_adjustments')

-- Jug pet skill lists mapped to mob species for utilization in Sic.
-- Baseline skill lists in mob_skill_list.sql for jugs map to pet_skill.sql for use in "Ready"
-- This breaks when reverting to Sic, causing jug pets to use the wrong skills
local jugSkillLists =
{
    [xi.mobSpecies.RABBIT]       = 206,
    [xi.mobSpecies.SHEEP]        = 226,
    [xi.mobSpecies.CRAB]         = 372,
    [xi.mobSpecies.MANDRAGORA]   = 903,
    [xi.mobSpecies.TIGER]        = 242,
    [xi.mobSpecies.FLYTRAP]      = 114,
    [xi.mobSpecies.HILL_LIZARD]  = 174,
    [xi.mobSpecies.FLY]          = 113,
    [xi.mobSpecies.EFT]          =  98,
    [xi.mobSpecies.FUNGUAR]      = 116,
    [xi.mobSpecies.BEETLE]       =  49,
    [xi.mobSpecies.ANTLION]      =  26,
    [xi.mobSpecies.DIREMITE]     =  81,
    [xi.mobSpecies.SABOTENDER]   = 939,
}

-- Jug Pets: Applies a skill list on spawn of pet to properly utilize Sic.
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(11/09/2009)
m:addOverrideByEra('xi.pets.jug.onPetStatCalculate', {
    [xi.expansion.WOTG] = function(master, pet)
        super(master, pet)

        if pet then
            local listId = jugSkillLists[pet:getSpecies()]
            if listId then
                pet:setMobMod(xi.mobMod.SKILL_LIST, listId)
            end
        end
    end,
})
