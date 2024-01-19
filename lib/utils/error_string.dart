String errorString(e) {
  String error = e.toString();
  if (error.split(":").length > 1) {
    error = error.split(":")[1].trim();
  }
  if (error.split("]").length > 1) {
    if (error.split(":").length > 1) {
      error = error.split(":")[1].trim();
    }
  }
  if (error.contains("too many") || error.contains("blocked")) {
    error = "Too many requests, please wait for an hour!";
  } else if (error.contains("firebase")) {
    error = "Error happened!";
  }
  return error;
}
