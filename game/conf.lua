function love.conf(t)
    isFullscreen = true

    t.title = "ReloadReload"        -- The title of the window the game is in (string)
    t.author = "Fabian Gerhardt, Iwan Gabovitch & Christiaan Janssen"        -- The author of the game (string)
    t.url = nil                 -- The website of the game (string)
    t.identity = "reloadreload"        -- The name of the save directory (string)
    if t.version == "0.8.0" then
        loveVersion = 8
        t.screen.width = 0        -- The window width (number)
        t.screen.height = 0       -- The window height (number)
        t.screen.fullscreen = isFullscreen -- Enable fullscreen (boolean)
        t.screen.vsync = true       -- Enable vertical sync (boolean)
        t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    else
        loveVersion = 9
        t.version = "0.9.0"         -- The LÖVE version this game was made for (string)
        t.window.width = 0        -- The window width (number)
        t.window.height = 0       -- The window height (number)
        t.window.fullscreen = isFullscreen -- Enable fullscreen (boolean)
        t.window.vsync = true       -- Enable vertical sync (boolean)
        t.window.fsaa = 0           -- The number of FSAA-buffers (number)
    end
    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = true      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = true      -- Enable the sound module (boolean)
    t.modules.physics = false    -- Enable the physics module (boolean)
end
