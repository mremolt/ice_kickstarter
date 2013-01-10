$ ->
  debug_marker = false
  marker_count = 0

  next_marker_id = ->
    ++marker_count

  init_marker = (marker_target) ->
    console.log(marker_target) if debug_marker
    marker_id = next_marker_id()
    marker_target.attr("data-marker-id", marker_id)
    box_id = marker_target.attr("data-box-ref")
    title = marker_target.attr("title") || "Edit"

    marker = $("<a></a>")
    marker.attr
      class: "marker"
      href: "https://<%= tenant_name %>.saas.infopark.net/cms/##{box_id};dc"
      target: "cms"
      "data-marker-ref": marker_id
      title: title
    marker.val(title)
    $("body").append(marker);

  init_markers = ->
    console.log("init markers") if debug_marker
    marker_targets = $("span.marker")
    if marker_targets.length > 0
      marker_targets.each ->
        init_marker($(this))
      redraw_markers()
      $("body").click ->
        redraw_markers()
      $(window).resize ->
        redraw_markers()

  redraw_markers = ->
    console.log("hide invisible markers") if debug_marker
    $("span.marker:hidden").each ->
      console.log($(this)) if debug_marker
      marker_id = $(this).attr("data-marker-id")
      marker = $("a.marker[data-marker-ref='#{marker_id}']")
      marker.hide()

    console.log("show visible markers") if debug_marker
    $("span.marker:visible").each ->
      console.log($(this)) if debug_marker
      marker_id = $(this).attr("data-marker-id")
      marker = $("a.marker[data-marker-ref='#{marker_id}']")
      pos = $(this).offset()
      marker.css
        left: pos.left
        top: pos.top
        display: "inline"

  init_markers()
