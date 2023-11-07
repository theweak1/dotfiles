local status_ok, shade = pcall(require, 'shade')
if not status_ok then
    print 'shade is not installed.'
    return
end


shade.setup {
    overlay_opacity = 30,
    opacity_step = 1,
    active = false, -- Set this to false to start with shade disabled
    keys = {
        brightness_up   = '<C-Up>',
        brightness_down = '<C-Down>',
        toggle          = '<Leader>ts'
    }
}
