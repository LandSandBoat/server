-----------------------------------
-- Mog Bonanza
-----------------------------------
xi = xi or {}
xi.bonanza = xi.bonanza or {}

--- Event name stored in Marble exdata for title rendering
--- Source: ROM/187/69.DAT
---@enum xi.bonanza.eventId
xi.bonanza.eventId =
{
    SIXTH_ANNIVERSARY               = 64, -- 6th Anniversary Mog Bonanza
    SEVENTH_ANNIVERSARY             = 65, -- 7th Anniversary Mog Bonanza
    MOGGY_NEW_YEAR                  = 66, -- Moggy New Year Bonanza
    EIGHTH_VANAVERSARY              = 67, -- 8th Vana'versary Mog Bonanza
    MOGGY_NEW_YEAR_2                = 68, -- Moggy New Year Bonanza
    NINTH_VANAVERSARY               = 69, -- 9th Vana'versary Mog Bonanza
    HOMECOMING                      = 70, -- Mog Bonanza Homecoming
    ELEVENTH_VANAVERSARY            = 71, -- 11th Vana'versary Mog Bonanza
    I_DREAM_2014                    = 72, -- I Dream of Mog Bonanza 2014
    TWELFTH_VANAVERSARY             = 73, -- 12th Vana'versary Mog Bonanza
    I_DREAM_2015                    = 74, -- I Dream of Mog Bonanza 2015
    THIRTEENTH_VANAVERSARY          = 75, -- 13th Vana'versary Mog Bonanza
    RHAPSODIES                      = 76, -- Rhapsodies Mog Bonanza
    FOURTEENTH_VANAVERSARY          = 77, -- 14th Vana'versary Mog Bonanza
    I_DREAM_2017                    = 78, -- I Dream of Mog Bonanza 2017
    FIFTEENTH_VANAVERSARY           = 79, -- 15th Vana'versary Mog Bonanza
    I_DREAM_2018                    = 80, -- I Dream of Mog Bonanza 2018
    SIXTEENTH_VANAVERSARY           = 81, -- 16th Vana'versary Mog Bonanza
    I_DREAM_2019                    = 82, -- I Dream of Mog Bonanza 2019
    SEVENTEENTH_VANAVERSARY         = 83, -- 17th Vana'versary Mog Bonanza
    I_DREAM_2020                    = 84, -- I Dream of Mog Bonanza 2020
    NEW_YEARS_NOMAD_2021            = 85, -- New Year's Nomad Mog Bonanza 2021
    EARLY_SPRING_NOMAD              = 86, -- Early Spring Nomad Mog Bonanza
    NINETEENTH_VANAVERSARY_NOMAD    = 87, -- 19th Vana'versary Nomad Mog Bonanza
    MIDSUMMERS                      = 88, -- A Midsummer's Mog Bonanza
    NEW_YEARS_NOMAD_2022            = 89, -- New Year's Nomad Mog Bonanza 2022
    TWENTIETH_VANAVERSARY_NOMAD     = 90, -- 20th Vana'versary Nomad Mog Bonanza
    NEW_YEARS_NOMAD_2023            = 91, -- New Year's Nomad Mog Bonanza 2023
    TWENTY_FIRST_VANAVERSARY_NOMAD  = 92, -- 21st Vana'versary Nomad Mog Bonanza
    NEW_YEARS_NOMAD_2024            = 93, -- New Year's Nomad Mog Bonanza 2024
    TWENTY_SECOND_VANAVERSARY_NOMAD = 94, -- 22nd Vana'versary Nomad Mog Bonanza
    NEW_YEARS_NOMAD_2025            = 95, -- New Year's Nomad Mog Bonanza 2025
    TWENTY_THIRD_VANAVERSARY_NOMAD  = 96, -- 23rd Vana'versary Nomad Mog Bonanza
    NEW_YEARS_NOMAD_2026            = 97, -- New Year's Nomad Mog Bonanza 2026
}
