boolean radiusCollision (PVector pv1, float r1, PVector pv2, float r2) {
  float distanceBetween = pv1.dist(pv2);
  if (distanceBetween < (r1+r2)*0.5) {
    return true;
  }
  return false;
}

boolean bounceVertical (PVector pos, int radius) {
  if (pos.y - radius < 0 || pos.y + radius > height) {
    return true;
  }
  return false;
}

boolean bounceHorizontal (PVector pos, int radius) {
  if (pos.x - radius < 0 || pos.x + radius > width) {
    return true;
  }
  return false;
}
