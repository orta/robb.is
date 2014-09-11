base = 32 #px

snap = ->
  for element in document.querySelectorAll 'article section > *'
    height = element.offsetHeight

    if element.dataset?.aspectRatio?
      height = Math.floor element.dataset.aspectRatio * element.offsetWidth

      element.style.height = "#{height}px"

    offset = Math.ceil(height / base) * base - height

    continue if offset is 0

    unless element.dataset.originalMarginBottom?
      style = window.getComputedStyle(element)
      value = style['margin-bottom'] or style['marginBottom'] or '0px'
      element.dataset.originalMarginBottom = value

    offset += parseFloat element.dataset.originalMarginBottom

    element.style.marginBottom = "#{offset}px"

window.addEventListener 'resize', snap
document.addEventListener 'DOMContentLoaded', snap
