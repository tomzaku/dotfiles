# pyright: reportMissingImports=false
from datetime import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.utils import color_as_int
from pathlib import Path
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)

opts = get_options()
icon_fg = as_rgb(color_as_int(opts.color16))
icon_bg = as_rgb(color_as_int(opts.color8))
bat_text_color = as_rgb(color_as_int(opts.color15))
clock_color = as_rgb(color_as_int(opts.color15))
date_color = as_rgb(color_as_int(opts.color8))

SEPARATOR_SYMBOL_LEFT, SEPARATOR_SYMBOL_RIGHT = ("", "")
RIGHT_MARGIN = 1
# REFRESH_TIME = 1

TRUNCATION_SYMBOL = " "
# pwd: current path
def get_cwd():
    cwd = ""
    tab_manager = get_boss().active_tab_manager
    if tab_manager is not None:
        window = tab_manager.active_window
        if window is not None:
            cwd = window.cwd_of_child

    cwd_parts = list(Path(cwd).parts)
    
    if len(cwd_parts) < 5:
        cwd = cwd_parts[0] + "/".join(cwd_parts[1:])
    else:
        cwd = ("/".join(cwd_parts[-2:]))

    cwd = TRUNCATION_SYMBOL + cwd
    return cwd


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    tab_bg = screen.cursor.bg
    tab_fg = screen.cursor.fg
    default_bg = as_rgb(int(draw_data.default_bg))

    screen.cursor.bg = default_bg
    screen.cursor.fg = tab_bg
    screen.draw(SEPARATOR_SYMBOL_LEFT)

    screen.cursor.bg = tab_bg
    screen.cursor.fg = tab_fg
    draw_title(draw_data, screen, tab, index)

    screen.cursor.bg = default_bg
    screen.cursor.fg = tab_bg
    screen.draw(SEPARATOR_SYMBOL_RIGHT)

    screen.cursor.bg = default_bg
    screen.draw(" ")
    end = screen.cursor.x
    return end


def _draw_right_status(screen: Screen, is_last: bool, cells: list, index: int) -> int:
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.x = screen.columns - right_status_length
    screen.cursor.fg = 0
    for color, status in cells:
        screen.cursor.fg = color
        screen.draw(status)
    screen.cursor.bg = 0
    
    return screen.cursor.x


def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()

right_status_length = -1

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global right_status_length
    # clock = datetime.now().strftime(" %H:%M")
    # date = datetime.now().strftime(" %d.%m.%Y")
    cells = []
    # cells.append((clock_color, clock))
    # cells.append((date_color, date))
    cells.append((date_color, get_cwd()))
    right_status_length = RIGHT_MARGIN
    for cell in cells:
        right_status_length += len(str(cell[1]))

    
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
        cells,
        index,
    )
    return screen.cursor.x
